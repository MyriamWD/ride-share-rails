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
    it "renders the form to edit a passenger" do
      passenger = Passenger.create(name: "test passenger", phone_num: "123-456-7890")
      valid_passenger_id = passenger.id
      get edit_passenger_path(valid_passenger_id)
      must_respond_with :success
    end

    it "responds with 404 when trying to edit a non existant passenger" do
      invalid_passenger_id = "im a fake id"
      get edit_passenger_path(invalid_passenger_id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    it "updates an existing passenger" do
      passenger_input = {
        name: "test passenger",
        phone_num: "123-456-7890",
      }
      passenger_to_update = Passenger.create(passenger_input)
      update_input = {
        passenger: {
          name: "updated passenger",
          phone_num: "564-456-4543",
        },
      }
      expect {
        patch passenger_path(passenger_to_update.id), params: update_input
      }.wont_change "Passenger.count"
      must_respond_with :redirect
      passenger_to_update.reload
      expect(passenger_to_update.name).must_equal update_input[:passenger][:name]
      expect(passenger_to_update.phone_num).must_equal update_input[:passenger][:phone_num]
    end

    it "will return a bad_request when trying to update with invalid data" do
      create_input = {
        name: "test passenger",
        phone_num: "123-456-7890",
      }
      passenger_to_update = Passenger.create(create_input)
      update_input = {
        passenger: {
          name: "",
          phone_num: "hey, what's up?",
        },
      }
      expect {
        patch passenger_path(passenger_to_update.id), params: update_input
      }.wont_change "Passenger.count"
      must_respond_with :bad_request
      passenger_to_update.reload
      expect(passenger_to_update.name).must_equal create_input[:name]
      expect(passenger_to_update.phone_num).must_equal create_input[:phone_num]
    end
  end

  describe "new" do
    it "renders the form to create a new passenger" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new passenger" do
      passenger_create = {
        passenger: {
          name: "Ms Nice",
          phone_num: "465-643-4565",
        },
      }

      expect {
        post passengers_path, params: passenger_create
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_create[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_create[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end

    it "will render the same form when trying to create a passenger with invalid data" do
      passenger_create = {
        passenger: {
          name: "",
          phone_num: "465-643-4565",
        },
      }

      expect {
        post passengers_path, params: passenger_create
      }.wont_change "Passenger.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    # Your tests go here
  end
end
