module Appointments
  module Services
    class Create
      def self.run(params)
        appointment = Appointment.new(
          doctor_id: params[:doctor_id],
          user_id: params[:user_id],
          schedule_id: params[:schedule_id]
        )

        if appointment.save
          return :created, appointment
        else
          return :failed, appointment
        end
      end
    end
  end
end
