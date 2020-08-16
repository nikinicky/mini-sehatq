module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :authenticate_user, only: [:create]
      skip_before_action :verify_authenticity_token, only: [:create]

      def create
        status, @user = Users::Services::Create.run(user_params)

        if status != :created
          render json: {message: generate_message(@user)}, status: :unprocessable_entity
        end

        _, @user_token = UserTokens::Services::Create.run(@user)
      end

      private

      def user_params
        params[:gender] = params[:gender].downcase if params[:gender].present?
        params.permit(:full_name, :email, :password, :gender, :birthday, :is_doctor)
      end

      def generate_message(user)
        return "" if user.errors.messages.nil?

        if user.errors.full_messages.size > 1
          user.errors.full_messages.join(', ')
        else
          user.errors.full_messages.join
        end
      end
    end
  end
end
