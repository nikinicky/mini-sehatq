require 'rails_helper'

RSpec.describe 'Api::V1::UsersController', type: :request do
  describe 'POST #create' do
    before do
      @params = {
        full_name: 'Nicky Valentino', 
        email: 'nickyv.valentino@gmail.com',
        password: 'sehatq'
      }
    end

    context 'with valid params' do
      it 'should return 200 status code' do
        post api_v1_create_user_path, params: @params

        expect(response.status).to eq(200)
      end
    end

    context 'with empty email' do
      it 'should return 422 and error message' do
        @params[:email] = nil
        post api_v1_create_user_path, params: @params

        expectation = {message: "Email can't be blank, Email is invalid"}.with_indifferent_access

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end

    context 'with duplicate email' do
      it 'should return 422 and error message' do
        post api_v1_create_user_path, params: @params
        post api_v1_create_user_path, params: @params

        expectation = {message: "Email has already been taken"}.with_indifferent_access

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end

    context 'with empty password' do
      it 'should return 422 and error message' do
        @params[:password] = nil
        post api_v1_create_user_path, params: @params

        expectation = {message: "Password can't be blank"}.with_indifferent_access

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end

    context 'with empty name' do
      it 'should return 422 and error message' do
        @params[:full_name] = nil
        post api_v1_create_user_path, params: @params

        expectation = {
          message: "Full name can't be blank, Full name is too short (minimum is 3 characters)"
        }.with_indifferent_access

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq(expectation)
      end
    end
  end
end
