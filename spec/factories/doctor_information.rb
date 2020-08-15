FactoryBot.define do
  factory :doctor_information do
    description { Faker::Lorem.sentence }
    speciality_id { create(:doctor_speciality).id }
  end
end
