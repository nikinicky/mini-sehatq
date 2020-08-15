FactoryBot.define do
  factory :hospital_type do
    name { Faker::Company.industry }
  end
end
