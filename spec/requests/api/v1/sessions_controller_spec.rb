require 'rails_helper'

RSpec.describe 'Api::V1::SessionsController', type: :request do
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

  describe 'POST #login' do
    before do
      @params = { email: user.email, password: user.password }
    end

    context 'with valid email and password' do
      before do
        post api_v1_login_path, params: @params 
      end

      it 'should return 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return user data and token' do
        expectation = {
          user: {
            id: user.id,
            full_name: user.full_name,
            email: user.email,
            birthday: user.birthday,
            age: user.age,
            gender: user.gender,
            is_doctor: user.is_doctor,
            token: user.user_tokens.last.token
          }
        }.with_indifferent_access

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end

    context 'with invalid email or password' do
      before do
        @params[:email] = user.email + 'x'
        post api_v1_login_path, params: @params 
      end

      it 'should return 422 status code' do
        expect(response.status).to eq(422)
      end

      it 'should return error message' do
        expectation = {
          message: "The email address or password you entered is incorrect."
        }.with_indifferent_access

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end

  describe 'POST #logout' do
    context 'with valid User-Access-Token' do
      before do
        headers = { 'User-Access-Token' => user_token.token }.with_indifferent_access
        post api_v1_logout_path, headers: headers
      end

      it 'should return 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return message' do
        expectation = {
          message: "You have successfully logged out."
        }.with_indifferent_access

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end

    context 'with invalid User-Access-Token' do
      before do
        headers = { 'User-Access-Token' => 'xxxxx' }.with_indifferent_access
        post api_v1_logout_path, headers: headers
      end

      it 'should return 401 status code' do
        expect(response.status).to eq(401)
      end

      it 'should return message' do
        expectation = {
          message: "Unauthorized"
        }.with_indifferent_access

        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end
end
