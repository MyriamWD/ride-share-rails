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

  def edit
    @driver = Driver.find_by(id: params[:id])
  end

  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
    else
      driver.destroy
      redirect_to drivers_path
    end
  end
end
