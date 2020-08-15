module Api
  module V1
    class HospitalsController < Api::V1::BaseController
      skip_before_action :authenticate_user

      def index
        status, @hospitals = Hospitals::Queries::All.run

        if status != :found
          render json: {
            message: "No hospital found."
          }, status: :ok
        end
      end
    end
  end
end
