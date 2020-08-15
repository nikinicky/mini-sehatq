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
end
