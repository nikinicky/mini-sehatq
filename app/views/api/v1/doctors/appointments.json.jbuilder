json.appointments @appointments do |appointment|
  json.hospital appointment.doctor_schedule.hospital.name
    json.district appointment.doctor_schedule.hospital.district
    json.date appointment.doctor_schedule.format_session_date
    json.time appointment.doctor_schedule.format_session_hour
    json.patient appointment.user.full_name
    json.gender appointment.user.gender
    json.age appointment.user.age
end
