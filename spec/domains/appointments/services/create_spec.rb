require 'rails_helper'

RSpec.describe 'Appointments::Services::Create', type: :integration do
  describe '.run' do
    before do
      @user = create(:user)
      @doctor = create(:doctor)
      @hospital = @doctor.doctor_information.hospitals.first
      @schedule = create(:doctor_schedule, doctor: @doctor, hospital: @hospital)

      @params = {
        user_id: @user.id,
        doctor_id: @doctor.id,
        schedule_id: @schedule.id
      }
    end

    context 'with valid params' do
      it 'should create appointment' do
        status, appointment = Appointments::Services::Create.run(@params)

        expect(status).to eq(:created)
        expect(appointment.persisted?).to eq(true)
      end
    end
  end
end
