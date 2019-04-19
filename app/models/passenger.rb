class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :phone_num, presence: true

  def total_cost
    total = self.trips.sum { |trip| trip.cost } / 100

    return total
  end
end
