FactoryBot.define do
  factory :doctor_schedule do
    date { (DateTime.now + 10.days).strftime('%Y-%m-%d') }
    start_hour { '9:00' }
    end_hour { '10:00' }
  end
end
