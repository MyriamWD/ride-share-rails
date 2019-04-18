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
    # Your tests go here
  end
end
