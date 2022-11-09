class ParticipantsController < ApplicationController
  before_action :authenticate_user
  
  def create # using invite system for participant. Create unaccepted invite here.

    # only trip creator may add people at this time. Change to by authorization later.
    trip = Trip.find_by(id: params[:trip_id])
    if current_user.id == trip.user.id
      participant = Participant.new(trip_id: params[:trip_id])
      user = User.find_by(email: params[:email])
      if user
        participant.user_id = user.id
      else
        participant.email = params[:email]
      end
      
      if params[:authority]
        participant.authority = params[:authority]
      end

      participant.save
      render json: participant
    else
      render json: {error: "you do not have sufficient authority to add people to this trip"}, status: :unauthorized
    end
  end

  def update # accept invite and/or modify authority
    participant = Participant.find_by(id: params[:id])
    participant.accepted = params[:accepted] || participant.accepted  
    participant.authority = params[:authority] || participant.authority 

    participant.save
    render json: participant
  end

  def index
    # shows either all participants added to a trip (add authority to see accepted vs unaccepted) OR all of an individual user's invited
    if params[:trip_id] 
      trip = Trip.find_by(id: params[:trip_id])
      participants = trip.participants
      p current_user.id
      p participants.pluck(:id)
      if trip.user.id == current_user.id || participants.pluck(:user_id).include?(current_user.id) # determines if current user is trip owner or participant
        render json: participants
      else
        render json: {error: "you do not have permission to view event participants"}
      end
    else
      participants = Participant.where(user_id: current_user.id)
      render json: participants
    end
  end

  def destroy
    # Only trip creator and participant can delete at this point
    participant = Participant.find_by(id: params[:id])
    trip = Trip.find_by(id: participant.trip_id)
    if trip.user.id == current_user.id || current_user.id == participant.user_id # should I account for invididual denying invite without having an account?
      participant.destroy
      render json: {message: "Participant has been removed"}
    else
      render json: {error: "you do not have sufficient authority to remove this participant"}, status: :unauthorized
    end
  end

end
