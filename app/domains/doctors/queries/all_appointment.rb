module Doctors
  module Queries
    class AllAppointment
      def self.run(doctor, params)
        schedule_ids = DoctorSchedule.where(doctor: doctor, date: params[:date]).pluck(:id)
        appointments = Appointment.where(doctor: doctor, schedule_id: schedule_ids)

        appointments = appointments.select do |appointment|
          appointment.order.status == Order::PAID
        end

        if appointments.present?
          return :found, appointments
        else
          return :not_found, appointments
        end
      end
    end
  end
end
