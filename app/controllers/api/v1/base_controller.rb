module Api
  module V1
    class BaseController < ApplicationController
      before_action { request.format = :json }
      before_action :authenticate_user

      def authenticate_user
        user_token = UserToken.find_by(token: request.headers['User-Access-Token'])

        unless user_token.present?
          render json: {message: 'Unauthorized'}, status: :unauthorized and return
        end

        if user_token.expires_in > Time.now.to_i
          @current_user = user_token.user
        else
          render json: {message: 'Unauthorized'}, status: :unauthorized
        end
      end

      def current_user
        @current_user
      end
    end
  end
end
