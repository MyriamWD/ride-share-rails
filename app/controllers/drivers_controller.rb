class DriversController < ApplicationController
  def index
    @drivers = Driver.where(deleted: false).order(:id)
  end

  def show
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id, deleted: false)
    @trips = Trip.where(driver_id: driver_id)
    if @driver.nil?
      head :not_found
    end
  end

  def new
    @driver = Driver.new(name: "Default Name", vin: "Default Vin", deleted: :false)
  end

  def create
    @driver = Driver.new(driver_params)
    @driver[:deleted] = false
    is_successful = @driver.save

    if is_successful
      redirect_to driver_path(@driver.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
    end
  end

  def update
    driver = Driver.find_by(id: params[:id])

    is_successful = driver.update(driver_params)

    if is_successful
      redirect_to driver_path(driver.id)
    else
      @driver = driver
      render :edit, status: :bad_request
    end
  end

  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
    else
      driver[:deleted] = true
      driver.save
      redirect_to drivers_path
    end
  end

  def home_page
  end

  def driver_params
    return params.require(:driver).permit(:name, :vin)
  end
end
