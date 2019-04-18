class TripsController < ApplicationController
  #   def index
  #     # We migth not need this index action - we can decide if we want to display information about it
  #     @trips = Trips.all.order(:id)
  #   end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
    end
  end

  def new
    @trip = Trip.new(:date, :driver_id, :passenger_id, :cost, :rating)
  end

  def create
    @trip = Trip.new(trip_params)
    is_successful = @trip.save

    if is_successful
      redirect_to trip_path(@trip.id)
    else
      render :new, status: :bad_request
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    trip.destroy
  end

  def trip_params
    return params.require(:trip).permit(:date, :driver_id, :passenger_id, :cost, :rating)
  end
end
