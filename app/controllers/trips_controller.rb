class TripsController < ApplicationController
  before_action :authenticate_user

  def index
    trips = Trip.where(user_id: current_user.id)
    render json: trips
  end

  def show
    trip = Trip.find_by(id: params[:id])
    if trip.user_id == current_user.id # add or condition for participants
      render json: trip
    else
      render json: {error: "you do not have permission to view this trip"}, status: :unauthorized
    end
  end

  def create
    start_day = Date.new(params[:start_year], params[:start_month], params[:start_day])
    end_day = Date.new(params[:end_year], params[:end_month], params[:end_day])
    trip = Trip.new(user_id: current_user.id, name: params[:name], destination_id: params[:destination_id], start_date: start_day, end_date: end_day)
    if trip.save
      render json: trip
    else
      render json: {errors: trip.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    trip = Trip.find_by(id: params[:id])
    if trip.user_id == current_user.id # add or condition for participants with edit authority
      start_day = Date.new(params[:start_year], params[:start_month], params[:start_day])
      end_day = Date.new(params[:end_year], params[:end_month], params[:end_day])

      trip.name = params[:name] || trip.name
      trip.destination_id = params[:destination_id] || trip.destination_id
      trip.start_date = start_day || trip.start_date
      trip.end_date = end_day || trip.end_date

      if trip.save
        render json: trip
      else
        render json: {errors: trip.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error: "you do not have permission to edit this trip"}, status: :unauthorized
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    if trip.user_id == current_user.id # add or condition for participants with authorization
      trip.delete
      render json: {message: "trip deleted"}
    else
      render json: {error: "you do not have permission to delete this trip"}, status: :unauthorized
    end
  end
end
