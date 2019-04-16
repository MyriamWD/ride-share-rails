class AddReferenceToTripsTableAndUpdateTripTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :trip, :trips
    add_reference :trips, :driver, foreign_key: true
    add_reference :trips, :passenger, foreign_key: true
  end
end
