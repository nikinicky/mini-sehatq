json.doctors doctors do |doctor|
  json.id doctor.id
  json.name doctor.full_name
  json.speciality doctor.speciality_name
  json.district doctor.doctor_information.district

  json.partial! 'api/v1/hospitals/hospitals', 
    locals: { hospitals: doctor.doctor_information.hospitals }
end
