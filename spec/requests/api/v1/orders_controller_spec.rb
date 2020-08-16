require 'rails_helper'

RSpec.describe 'Api::V1::OrdersController', type: :request do
  let(:user) do
    create(:user)
  end

  let(:user_token) do
    UserToken.create(
      user: user, 
      expires_in: (Time.now + 1.month).to_i, 
      token: SecureRandom.hex(24)
    )
  end

  let(:headers) do
    {
      'User-Access-Token': user_token.token
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        doctor = create(:doctor)
        hospital = doctor.doctor_information.hospitals.first
        schedule = create(:doctor_schedule, doctor: doctor, hospital: hospital)

        params = {
          doctor_id: doctor.id,
          user_id: user.id,
          schedule_id: schedule.id,
          payment_type: 'personal',
          notes: '-'
        }

        post api_v1_orders_path, params: params, headers: headers
      end

      it 'should return 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return order details' do
        order = Order.last

        expectation = {
          id: order.id,
          code: order.code,
          status: order.status,
          payment_type: order.payment_type,
          notes: order.notes,
          district: order.appointment.hospital.district,
          schedule_date: order.appointment.doctor_schedule.format_session_date,
          schedule_hour: order.appointment.doctor_schedule.format_session_hour,
          hospital: {
            id: order.appointment.hospital.id,
            name: order.appointment.hospital.name,
            support_emergency: order.appointment.hospital.support_emergency,
            hospital_type: order.appointment.hospital.type_name
          },
          doctor: {
            id: order.appointment.doctor.id,
            name: order.appointment.doctor.full_name,
            speciality: order.appointment.doctor.speciality_name,
          }
        }.with_indifferent_access

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end

  describe 'POST #checkout' do
    context 'with valid params' do
      before do
        doctor = create(:doctor)
        hospital = doctor.doctor_information.hospitals.first
        schedule = create(:doctor_schedule, doctor: doctor, hospital: hospital)

        params = {
          doctor_id: doctor.id,
          user_id: user.id,
          schedule_id: schedule.id,
          payment_type: 'personal',
          notes: '-'
        }

        post api_v1_orders_path, params: params, headers: headers

        order = Order.last
        post  checkout_api_v1_order_path(order), headers: headers
      end

      it 'should return 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should change order status to paid' do
        order = Order.last
        expect(order.status).to eq(Order::PAID)
      end
    end
  end
end
