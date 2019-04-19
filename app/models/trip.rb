class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :date, presence: true
  validates :rating, presence: true
  validates :cost, presence: true
  validates :driver_id, presence: true
  validates :passenger_id, presence: true
end
