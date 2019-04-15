class ChangeNameOfTripsTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :trips, :trip
  end
end
