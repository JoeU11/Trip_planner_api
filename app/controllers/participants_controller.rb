class ParticipantsController < ApplicationController
  before_action :authenticate_user
  
  def create #add invite system for participants?
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
  end
end
