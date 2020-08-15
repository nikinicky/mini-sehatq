require 'rails_helper'

RSpec.describe 'Api::V1::HospitalsController', type: :request do
  describe 'GET #index' do
    context 'there is some hospitals in the database' do
      before do
        create_list(:hospital, 5)
        get api_v1_hospitals_path
      end

      it 'should return 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return hospital list' do
        status, hospitals = Hospitals::Queries::All.run
        expectation = {hospitals: []}.with_indifferent_access

        hospitals.each do |hospital|
          expectation[:hospitals] << {
            id: hospital.id,
            name: hospital.name,
            district: hospital.district,
            open_hours: hospital.open_hours,
            support_emergency: hospital.support_emergency,
            hospital_type: hospital.type_name
          }.with_indifferent_access
        end

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end
end
