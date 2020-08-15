require 'rails_helper'

RSpec.describe 'UserTokens::Services::Create', type: :integration do
  describe '.run' do
    context 'with valid params' do
      it 'should create user token' do
        user = create(:user)
        status, user_token = UserTokens::Services::Create.run(user)

        expect(status).to eq(:created)
        expect(user_token.persisted?).to eq(true)
      end
    end

    context 'with invalid params' do
      it 'should not create user token' do
        user = build(:user)
        status, user_token = UserTokens::Services::Create.run(user)

        expect(status).to eq(:failed)
        expect(user_token.persisted?).to eq(false)
      end
    end
  end
end
