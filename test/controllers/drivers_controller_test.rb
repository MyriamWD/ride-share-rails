require "test_helper"

describe DriversController do
  describe "index" do
    it "can get index" do
      get drivers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "should be ok to show an existing, valid driver" do
      # skip
      driver = Driver.create(name: "test driver", vin: "badnvkadkvbdjoihuy79y")
      valid_driver_id = driver.id

      get driver_path(valid_driver_id)

      must_respond_with :success
    end

    it "should give a 404 instead of showing a non-existant, invalid driver" do
      invalid_driver_id = 8989898989

      get driver_path(invalid_driver_id)
      #determine how we want to handle this situation... probably redirect
      must_respond_with :not_found
    end
  end

  describe "edit" do
  end

  describe "update" do
    # Your tests go here
  end

  describe "new" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here
  end

  describe "destroy" do
    # Your tests go here
  end
end
