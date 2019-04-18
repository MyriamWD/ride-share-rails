class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    average = Trip.average(:rating).where(driver_id: driver_id)
  end

  def total_earnigns
  end
end
