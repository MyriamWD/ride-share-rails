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
    # Your tests go here
  end

  describe "update" do
    # Your tests go here
  end

  describe "create" do
    # Your tests go here

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
