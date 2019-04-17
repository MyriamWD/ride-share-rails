class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all.order(:id)
  end
end
