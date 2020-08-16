module Api
  module V1
    class DoctorsController < Api::V1::BaseController
      before_action :set_doctor, only: [:schedules]
      skip_before_action :authenticate_user

      def index
        status, @doctors = Doctors::Queries::All.run

        if status != :found
          render json: {
            message: "No doctors found."
          }, status: :ok
        end
      end

      def schedules
      end

      private

      def set_doctor
        @doctor = User.find_by(id: params[:id])
      end
    end
  end
end
