require 'rails_helper'

RSpec.describe 'Utilities::GenerateCode', type: :integration do
  describe '.for_order' do
    it 'should generate code' do
      ('B'..'D').each do |word|
        user = create(:user)
        doctor = create(:doctor)
        schedule = create(:doctor_schedule, doctor: doctor, hospital: doctor.doctor_information.hospitals.first)
        appointment = create(:appointment, doctor: doctor, user: user, schedule_id: schedule.id)

        create(:order, code: word, appointment: appointment)
      end

      result = Utilities::GenerateCode.for_order(length: 1, prefix: '', source: [*('A'..'D')])
      expect(result).to eq('A')
    end
  end
end
