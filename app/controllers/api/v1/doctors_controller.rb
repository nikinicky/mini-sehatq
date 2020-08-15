module Api
  module V1
    class DoctorsController < Api::V1::BaseController
      skip_before_action :authenticate_user

      def index
        status, @doctors = Doctors::Queries::All.run

        if status != :found
          render json: {
            message: "No doctors found."
          }, status: :ok
        end
      end
    end
  end
end
