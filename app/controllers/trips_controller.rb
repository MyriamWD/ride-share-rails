class TripsController < ApplicationController
  def destroy
    trip = Trip.find_by(id: params[:id])
    trip.destroy
  end
end
