module Appointments
  module Services
    class Create
      def self.run(params)
        return :cannot_book, nil unless can_book_this_schedule?(params[:schedule_id])
        return :unavailable, nil unless is_doctor_available?(params[:schedule_id])

        appointment = Appointment.new(
          doctor_id: params[:doctor_id],
          user_id: params[:user_id],
          schedule_id: params[:schedule_id]
        )

        more_than_order_threshold_time?(params[:schedule_id])

        if appointment.save
          return :created, appointment
        else
          return :failed, appointment
        end
      end

      def self.is_doctor_available?(schedule_id)
        schedule = DoctorSchedule.find_by(id: schedule_id)
        return false if schedule.nil?

        total_appointments = 0
        doctor_schedules = DoctorSchedule.where(date: schedule.date)

        doctor_schedules.each do |schedule|
          total_appointments += 1 if schedule.appointment.present?
        end

        return total_appointments < Appointment::THRESHOLD_USER_IN_A_DAY
      end

      def self.can_book_this_schedule?(schedule_id)
        [booked?(schedule_id), more_than_order_threshold_time?(schedule_id)].all?(false)
      end

      def self.booked?(schedule_id)
        Appointment.find_by(schedule_id: schedule_id).present?
      end

      def self.more_than_order_threshold_time?(schedule_id)
        schedule = DoctorSchedule.find_by(id: schedule_id)
        return true if schedule.nil?

        hour = schedule.start_hour.split(':').first
        minute = schedule.start_hour.split(':').second
        session_start = schedule.date.to_time.change(hour: hour, min: minute)
        threshold_time = Appointment::THRESHOLD_TIME.minutes

        return (session_start.to_i - Time.now.to_i) < threshold_time.to_i
      end
    end
  end
end
