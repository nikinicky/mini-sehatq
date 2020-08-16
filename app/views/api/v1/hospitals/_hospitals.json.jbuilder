json.id hospital.id
json.name hospital.name
json.district hospital.district
json.open_hours hospital.open_hours
json.support_emergency hospital.support_emergency
json.hospital_type hospital.type_name

if show_schedules
  json.schedules hospital.doctor_schedules.where(doctor_id: doctor_id) do |schedule|
    json.id schedule.id
    json.session_date schedule.format_session_date
    json.session_hour schedule.format_session_hour
    json.booked Appointments::Services::Create.booked?(schedule.id)
  end
end
