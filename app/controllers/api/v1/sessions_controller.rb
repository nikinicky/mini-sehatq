module Api
  module V1
    class SessionsController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token

      def login
      end
    end
  end
end
