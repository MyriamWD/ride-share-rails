require "test_helper"

describe TripsController do
  describe "show" do
    it "should show an existing, valid trip" do
      trip = Trip.create(date: "2019-4-18", driver_id: Driver.create(name: "Myriam", vin: "vinnumber").id, passenger_id: Passenger.create(name: "NotMyriam", phone_num: "phone humber call").id, rating: 5, cost: 3890)
      get trip_path(trip.id)
      must_respond_with :success
    end
  end

  describe "edit" do
    it "renders the form to edit a trip" do
      trip = Trip.create(date: "2019-4-18", driver_id: Driver.create(name: "Myriam", vin: "vinnumber").id, passenger_id: Passenger.create(name: "NotMyriam", phone_num: "phone humber call").id, rating: 5, cost: 3890)
      valid_trip_id = trip.id
      get edit_trip_path(valid_trip_id)

      must_respond_with :success
    end

    it "responds with 404 when trying to edit a non existant trip" do
      invalid_trip_id = "to trip or not to trip"
      get edit_trip_path(invalid_trip_id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    it "updates an existing trip" do
      create_trip_input = {
        date: "2019-4-18",
        driver_id: Driver.create(name: "driver name", vin: "vinnumber").id,
        passenger_id: Passenger.create(name: "passenger name",
                                       phone_num: "555 555 6678").id,
        rating: 5,
        cost: 3890,
      }

      trip_to_update = Trip.create(create_trip_input)

      update_trip_input = {
        "trip": {
          date: "2059-4-18",
          driver_id: Driver.create(name: "Bill Jobs", vin: "vinnumber").id,
          passenger_id: Passenger.create(name: "Sandra", phone_num: "phone humber call").id,
          rating: 3,
          cost: 890678,
        },
      }

      expect {
        patch trip_path(trip_to_update.id), params: update_trip_input
      }.wont_change "Trip.count"

      must_respond_with :redirect
      trip_to_update.reload
      expect(trip_to_update.date).must_equal update_trip_input[:trip][:date]
      expect(trip_to_update.driver_id).must_equal update_trip_input[:trip][:driver_id]
      expect(trip_to_update.passenger_id).must_equal update_trip_input[:trip][:passenger_id]
      expect(trip_to_update.rating).must_equal update_trip_input[:trip][:rating]
      expect(trip_to_update.cost).must_equal update_trip_input[:trip][:cost]
    end
  end

  describe "new" do
    it "renders the form to create a new trip" do
      get new_trip_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new trip" do
      trip_create = {
        trip: {
          date: "2016-3-25",
          driver_id: Driver.create(name: "Rosa Margarita", vin: "vinnumber").id,
          passenger_id: Passenger.create(name: "Melo", phone_num: "phone humber call").id,
          rating: 2,
          cost: 82,
        },
      }

      expect {
        post trips_path, params: trip_create
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(date: trip_create[:trip][:date])
      expect(new_trip.rating).must_equal trip_create[:trip][:rating]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip.id)
    end

    it "will render the same form when trying to create a trip with invalid data" do
      trip_create = {
        trip: {
          date: "2016-3-25",
          driver_id: Driver.create(name: "Rosa Margarita", vin: "vinnumber").id,
          passenger_id: Passenger.create(name: "Melo", phone_num: "phone humber call").id,
          rating: 2,
          cost: 82,
        },
      }
      expect {
        post trips_path, params: trip_create
      }.wont_change "Trip.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "successfully deletes a trip" do
      trip_create = {
        date: "2019-04-19",
        rating: 5,
        cost: 345,
        driver_id: Driver.create(name: "test driver", vin: "test vin").id,
        passenger_id: Passenger.create(name: "test passenger", phone_num: "123123123").id,
      }
      new_trip = Trip.create(trip_create)
      expect {
        delete trip_path(new_trip.id)
      }.must_change "Trip.count", -1
      must_respond_with :redirect
    end
    it "returns 404 if not found" do
      invalid_id = -1
      expect {
        delete trip_path(invalid_id)
      }.wont_change "Trip.count"
      must_respond_with :not_found
    end
  end
end
