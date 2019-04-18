class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    average = 0
    if self.trips != []
      average = self.trips.average(:rating).round
    end
    return average
  end

  def total_earnings
    total = self.trips.sum { |trip| (trip.cost - 165.0) * 0.80 } / 100

    return total.round(2)
  end
end
