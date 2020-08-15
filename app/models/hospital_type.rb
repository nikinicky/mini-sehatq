class HospitalType < ApplicationRecord
  validates_presence_of :name

  has_many :hospitals
end
