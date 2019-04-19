class TripsController < ApplicationController
  #   def index
  #     # We migth not need this index action - we can decide if we want to display information about it
  #     @trips = Trips.all.order(:id)
  #   end

  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    # redirect_to passenger_trip_path(@trip.id)
    if @trip.nil?
      head :not_found
    end
  end

  def new
    passenger_id = Passenger.find_by(id: passenger_id)
    @trip = Trip.new(date: "yyyy-mm-dd", driver_id: "id", passenger_id: passenger_id, cost: 0, rating: 0)
  end

  def create
    passenger = params[:passenger_id].to_i
    @trip = Trip.new(trip_params)
    @trip[:passenger_id] = passenger

    is_successful = @trip.save

    if is_successful
      redirect_to trip_path(@trip.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
    end
  end

  def update
    trip = Trip.find_by(id: params[:id])

    is_successful = trip.update(trip_params)

    if is_successful
      redirect_to trip_path(trip.id)
    else
      @trip = trip
      render :edit, status: :bad_request
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    if trip.nil?
      head :not_found
    else
      trip.destroy
      redirect_to root_path # make a home page for the website
    end
  end

  def trip_params
    return params.require(:trip).permit(:date, :driver_id, :passenger_id, :cost, :rating)
  end
end
