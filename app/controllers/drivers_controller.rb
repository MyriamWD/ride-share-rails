class DriversController < ApplicationController
  def index
    @drivers = Driver.all.order(:id)
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    @trips = Trip.where(driver_id: driver_id)
    if @driver.nil?
      head :not_found
    end
  end
end
