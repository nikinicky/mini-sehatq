require 'rails_helper'

RSpec.describe 'Doctors::Queries::AllAppointment', type: :integration do
  describe '.run' do
    context 'with valid params' do
      it 'should return all doctors appointments' do
        user = create(:user)
        doctor = create(:doctor)
        schedule = create(:doctor_schedule, doctor: doctor, hospital: doctor.doctor_information.hospitals.first)
        appointment = create(:appointment, doctor: doctor, user: user, schedule_id: schedule.id)
        order = create(:order, status: Order::PAID, code: Utilities::GenerateCode.for_order, appointment: appointment)

        params = {date: (DateTime.now + 10.days).strftime('%Y-%m-%d')}

        status, appointments = Doctors::Queries::AllAppointment.run(doctor, params)

        expect(status).to eq(:found)
        expect(appointments.size).to eq(1)
      end
    end
  end
end
