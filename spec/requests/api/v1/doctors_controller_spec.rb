require 'rails_helper'

RSpec.describe 'Api::V1::DoctorsController', type: :request do
  describe 'GET #index' do
    context 'there is some doctors in the database' do
      before do
        create_list(:doctor, 5)
        get api_v1_doctors_path
      end

      it 'should return 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return doctor list' do
        status, doctors = Doctors::Queries::All.run
        expectation = {doctors: []}.with_indifferent_access

        doctors.each do |doctor|
          object = {
            id: doctor.id,
            name: doctor.full_name,
            speciality: doctor.speciality_name,
            district: doctor.doctor_information.district,
            hospitals: []
          }.with_indifferent_access

          doctor.doctor_information.hospitals.each do |hospital|
            object[:hospitals] << {
              id: hospital.id,
              name: hospital.name,
              district: hospital.district,
              open_hours: hospital.open_hours,
              support_emergency: hospital.support_emergency,
              hospital_type: hospital.type_name
            }.with_indifferent_access
          end

          expectation[:doctors] << object
        end

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end

  describe 'GET #schedules' do
    context 'doctor has some schedules at a hospital' do
      before do
        @doctor = create(:doctor)
        session_date = (Time.now + 10.days).strftime('%Y-%m-%d')
        session_hours = [
          {start_hour: '8:00', end_hour: '9:00'},
          {start_hour: '9:00', end_hour: '10:00'}
        ]

        session_hours.each do |session|
          create(
            :doctor_schedule, 
            date: session_date, 
            start_hour: session[:start_hour], 
            end_hour: session[:end_hour], 
            doctor: @doctor, 
            hospital: @doctor.doctor_information.hospitals.first
          )
        end

        get schedules_api_v1_doctor_path(@doctor)
      end

      it 'should return 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return schedule list' do
        expectation = {}.with_indifferent_access
        doctor = @doctor

        object = {
          id: doctor.id,
          name: doctor.full_name,
          speciality: doctor.speciality_name,
          district: doctor.doctor_information.district,
          hospitals: []
        }.with_indifferent_access

        doctor.doctor_information.hospitals.each do |hospital|
          hospital_object = {
            id: hospital.id,
            name: hospital.name,
            district: hospital.district,
            open_hours: hospital.open_hours,
            support_emergency: hospital.support_emergency,
            hospital_type: hospital.type_name,
            schedules: []
          }.with_indifferent_access

          doctor.schedules.each do |schedule|
            hospital_object[:schedules] << {
              id: schedule.id,
              session_date: schedule.format_session_date,
              session_hour: schedule.format_session_hour,
              booked: Appointments::Services::Create.booked?(schedule.id)
            }.with_indifferent_access
          end

          object[:hospitals] << hospital_object
          expectation = object
        end

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end

  describe 'GET #appointments' do
    context 'doctor has some appointments' do
      it 'should return appointment list' do
        user = create(:user)
        user_2 = create(:user)
        doctor = create(:doctor)
        hospital = doctor.doctor_information.hospitals.first

        session_date = (Time.now + 10.days).strftime('%Y-%m-%d')
        session_hours = [
          {start_hour: '8:00', end_hour: '8:30'},
          {start_hour: '8:45', end_hour: '9:15'},
          {start_hour: '9:30', end_hour: '10:00'}
        ]

        session_hours.each do |session|
          create(
            :doctor_schedule, 
            date: session_date, 
            start_hour: session[:start_hour], 
            end_hour: session[:end_hour], 
            doctor: doctor, 
            hospital: doctor.doctor_information.hospitals.first
          )
        end

        schedules = DoctorSchedule.where(doctor_id: doctor.id, date: session_date)

        appointment_1 = create(:appointment, doctor: doctor, user: user, schedule_id: schedules.first.id)
        create(:order, status: Order::PAID, code: Utilities::GenerateCode.for_order, appointment: appointment_1)
        appointment_2 = create(:appointment, doctor: doctor, user: user_2, schedule_id: schedules.last.id)
        create(:order, status: Order::PAID, code: Utilities::GenerateCode.for_order, appointment: appointment_2)

        expectation = {
          appointments: [
            {
              hospital: appointment_1.doctor_schedule.hospital.name,
              district: appointment_1.doctor_schedule.hospital.district,
              date: appointment_1.doctor_schedule.format_session_date,
              time: appointment_1.doctor_schedule.format_session_hour,
              patient: appointment_1.user.full_name,
              gender: appointment_1.user.gender,
              age: appointment_1.user.age
            },
            {
              hospital: appointment_2.doctor_schedule.hospital.name,
              district: appointment_2.doctor_schedule.hospital.district,
              date: appointment_2.doctor_schedule.format_session_date,
              time: appointment_2.doctor_schedule.format_session_hour,
              patient: appointment_2.user.full_name,
              gender: appointment_2.user.gender,
              age: appointment_2.user.age
            }
          ]
        }.with_indifferent_access

        params = {date: session_date}
        get appointments_api_v1_doctor_path(doctor), params: params

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end
end
