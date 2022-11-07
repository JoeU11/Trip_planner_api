class TripsController < ApplicationController
  before_action :authenticate_user

  def index

  end

  def create
    start_day = Date.new(params[:start_year], params[:start_month], params[:start_day])
    end_day = Date.new(params[:end_year], params[:end_month], params[:end_day])
    trip = Trip.new(user_id: current_user.id, name: params[:name], destination_id: params[:destination_id], start_date: start_day, end_date: end_day)
    trip.save

    render json: {message: trip}
  end
end
