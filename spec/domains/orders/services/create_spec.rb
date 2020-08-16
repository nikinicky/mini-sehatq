require 'rails_helper'

RSpec.describe 'Orders::Services::Create', type: :integration do
  describe '.run' do
    before do
      @user = create(:user)
      @doctor = create(:doctor)
      @hospital = @doctor.doctor_information.hospitals.first
      @schedule = create(:doctor_schedule, doctor: @doctor, hospital: @hospital)
    end

    context 'with valid params' do
      it 'should create order' do
        params = {
          user_id: @user.id,
          doctor_id: @doctor.id,
          hospital_id: @hospital.id,
          schedule_id: @schedule.id,
          payment_type: 'personal',
          notes: '-'
        }

        status, order = Orders::Services::Create.run(params)

        expect(status).to eq(:created)
        expect(order.persisted?).to eq(true)
      end
    end
  end
end
