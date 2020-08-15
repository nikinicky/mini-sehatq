class Hospital < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :district

  belongs_to :hospital_type

  def type_name
    hospital_type&.name || "Rumah Sakit"
  end
end
