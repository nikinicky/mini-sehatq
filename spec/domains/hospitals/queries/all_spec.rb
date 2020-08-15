require 'rails_helper'

RSpec.describe 'Hospitals::Queries::All', type: :integration do
  describe '.run' do
    context 'without any params' do
      it 'should return all hospitals' do
        create_list(:hospital, 10)

        status, hospitals = Hospitals::Queries::All.run({})

        expect(status).to eq(:found)
        expect(hospitals.size).to eq(10)
      end
    end
  end
end
