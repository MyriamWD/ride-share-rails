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
