class PassengersController < ApplicationController
  def index
    @passengers = Passenger.where(deleted: false).order(:id)
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id, deleted: false)
    @trips = Trip.where(passenger_id: passenger_id)

    if @passenger.nil?
      head :not_found
    end
  end

  def new
    @passenger = Passenger.new(name: "Default Name", phone_num: "xxx-xxx-xxxx")
  end

  def create
    @passenger = Passenger.new(passenger_params)
    is_successful = @passenger.save

    if is_successful
      redirect_to passenger_path(@passenger.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
    end
  end

  def update
    passenger = Passenger.find_by(id: params[:id])

    is_successful = passenger.update(passenger_params)

    if is_successful
      redirect_to passenger_path(passenger.id)
    else
      @passenger = passenger
      render :edit, status: :bad_request
    end
  end

  def destroy
    passenger = Passenger.find_by(id: params[:id])

    if passenger.nil?
      head :not_found
    else
      passenger[:deleted] = true
      passenger.save
      redirect_to passengers_path
    end
  end

  def passenger_params
    return params.require(:passenger).permit(:name, :phone_num, :deleted)
  end
end
