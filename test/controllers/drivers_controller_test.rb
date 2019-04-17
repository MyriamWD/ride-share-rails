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
    it "renders the form to edit a driver" do
      driver = Driver.create(name: "test driver", vin: "badnvkadkvbdjoihuy79y")
      valid_driver_id = driver.id
      get edit_driver_path(valid_driver_id)

      must_respond_with :success
    end

    it "responds with 404 when trying to edit a non existant driver" do
      invalid_driver_id = "im a  fake id"
      get edit_driver_path(invalid_driver_id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    it "updates an existing driver" do
      create_input = {
        name: "The transporter",
        vin: "vinvinvin123",
      }

      driver_to_update = Driver.create(create_input)

      update_input = {
        "driver": {
          name: "Not the transporter",
          vin: "hey, what's up?",
        },
      }

      expect {
        patch driver_path(driver_to_update.id), params: update_input
      }.wont_change "Driver.count"

      must_respond_with :redirect
      driver_to_update.reload
      expect(driver_to_update.name).must_equal update_input[:driver][:name]
      expect(driver_to_update.vin).must_equal update_input[:driver][:vin]
    end

    it "will return a bad_request when trying to update with invalid data" do
      create_input = {
        name: "The transporter",
        vin: "vinvinvin123",
      }

      driver_to_update = Driver.create(create_input)

      update_input = {
        "driver": {
          name: "",
          vin: "hey, what's up?",
        },
      }

      expect {
        patch driver_path(driver_to_update.id), params: update_input
      }.wont_change "Driver.count"

      must_respond_with :bad_request
      driver_to_update.reload
      expect(driver_to_update.name).must_equal create_input[:name]
      expect(driver_to_update.vin).must_equal create_input[:vin]
    end
  end

  describe "new" do
    # Your tests go here
    it "renders the form to create a new driver" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new driver" do
      driver_create = {
        driver: {
          name: "Bark Alot",
          vin: "4legs",
        },
      }

      expect {
        post drivers_path, params: driver_create
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_create[:driver][:name])
      expect(new_driver.vin).must_equal driver_create[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "will render the same form when trying to create a driver with invalid data" do
      driver_create = {
        driver: {
          name: "",
          vin: "4legs",
        },
      }

      expect {
        post drivers_path, params: driver_create
      }.wont_change "Driver.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
  end
end
