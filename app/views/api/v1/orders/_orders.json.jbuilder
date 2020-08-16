json.id order.id
json.code order.code
json.status order.status
json.payment_type order.payment_type
json.notes order.notes
json.district order.appointment.hospital.district
json.schedule_date order.appointment.doctor_schedule.format_session_date
json.schedule_hour order.appointment.doctor_schedule.format_session_hour

json.hospital do
  json.id order.appointment.hospital.id
  json.name order.appointment.hospital.name
  json.support_emergency order.appointment.hospital.support_emergency
  json.hospital_type order.appointment.hospital.type_name
end

json.doctor do
  json.id order.appointment.doctor.id
  json.name order.appointment.doctor.full_name
  json.speciality order.appointment.doctor.speciality_name
end
