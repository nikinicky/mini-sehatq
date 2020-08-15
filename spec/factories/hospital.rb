FactoryBot.define do
  factory :hospital do
    name { Faker::Company.name }
    district { Faker::Address.city }
    address { Faker::Address.street_address }
    open_hours { "Senin - Jum'at 08:00 - 21:00" }
    support_emergency { [true, false].sample }
    hospital_type { create(:hospital_type) }
  end
end
