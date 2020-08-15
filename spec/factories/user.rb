FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'sehatq' }

    factory :doctor do
      full_name { Faker::Name.name }
      email { Faker::Internet.email }
      password { 'sehatq' }
      is_doctor { true }

      after(:create) do |doctor, evaluator|
        if evaluator.is_doctor
          hospital = create(:hospital)
          create(:doctor_information, hospital_ids: [hospital.id], doctor: doctor)
        end
      end
    end
  end
end
