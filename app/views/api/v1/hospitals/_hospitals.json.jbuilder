json.hospitals hospitals do |hospital|
  json.id hospital.id
  json.name hospital.name
  json.district hospital.district
  json.open_hours hospital.open_hours
  json.support_emergency hospital.support_emergency
  json.hospital_type hospital.type_name
end
