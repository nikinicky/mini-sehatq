class DoctorSchedule < ApplicationRecord
  belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
  belongs_to :hospital

  has_one :appointment, foreign_key: 'schedule_id'

  def format_session_hour
    format_start_hour + ' - ' + format_end_hour
  end

  def format_start_hour
    hour = start_hour.split(':').first
    minute = start_hour.split(':').second

    session_start = date.to_time.change(hour: hour, min: minute)
    return I18n.l(session_start, format: '%H:%M')
  end

  def format_end_hour
    hour = end_hour.split(':').first
    minute = end_hour.split(':').second

    session_end = date.to_time.change(hour: hour, min: minute)
    return I18n.l(session_end, format: '%H:%M')
  end

  def format_session_date
    date.strftime('%A, %-d %B %Y')
  end
end
