require "test_helper"

describe PassengersController do
  describe "index" do
    it "should get index" do
      get passengers_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should show an existing, valid passenger" do

      # Arrange
      passenger = Passenger.create(name: "test passenger", phone_num: "123-456-7890")
      valid_passenger_id = passenger.id

      # Act
      get passenger_path(valid_passenger_id)

      # Assert
      must_respond_with :success
    end

    it "should give a 404 instead of showing a non-existant, invalid passenger" do

      # Arrange
      invalid_passenger_id = -1

      # Act
      get passenger_path(invalid_passenger_id)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "edit" do
    # Your tests go here
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
