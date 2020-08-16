module Api
  module V1
    class DoctorsController < Api::V1::BaseController
      before_action :set_doctor, except: [:index]
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
        if @doctor.nil?
          render json: {
            message: "No doctor found."
          }, status: :ok
        end
      end

      def appointments
        status, @appointments = Doctors::Queries::AllAppointment.run(@doctor, appointment_params)

        if status != :found
          render json: {
            message: "No appointments found."
          }, status: :ok
        end
      end

      private

      def set_doctor
        @doctor = User.find_by(id: params[:id])
      end

      def appointment_params
        params.permit(:date)
      end
    end
  end
end
