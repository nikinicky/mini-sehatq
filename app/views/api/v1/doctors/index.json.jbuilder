json.doctors @doctors do |doctor|
  json.partial! 'api/v1/doctors/doctors', locals: { doctor: doctor }
end
