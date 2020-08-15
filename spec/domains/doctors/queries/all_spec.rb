require 'rails_helper'

RSpec.describe 'Doctors::Queries::All', type: :integration do
  describe '.run' do
    context 'without any params' do
      it 'should return all doctors' do
        create_list(:doctor, 10)

        status, doctors = Doctors::Queries::All.run({})

        expect(status).to eq(:found)
        expect(doctors.size).to eq(10)
      end
    end
  end
end
