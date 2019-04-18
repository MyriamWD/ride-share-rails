class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  def average_rating
    Trip.average(:rating)
  end

  def total_earnigns
  end
end
