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
    if self.trips.length == 0
      total_earnings = 0
    else
      total = (self.trips.sum { |trip| (trip.cost - 165.0) * 0.80 } / 100).round(2)
    end

    return total
  end
end
