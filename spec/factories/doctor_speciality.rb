FactoryBot.define do
  factory :doctor_speciality do
    name { Faker::Job.title }
  end
end
