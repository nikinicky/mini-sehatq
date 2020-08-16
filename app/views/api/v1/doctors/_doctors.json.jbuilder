json.id doctor.id
json.name doctor.full_name
json.speciality doctor.speciality_name
json.district doctor.doctor_information.district

doctor_id = doctor.id || nil
show_schedules = show_schedules || nil
json.hospitals doctor.doctor_information.hospitals do |hospital|
  json.partial! 'api/v1/hospitals/hospitals', locals: { hospital: hospital, doctor_id: doctor_id, show_schedules: show_schedules }
end
