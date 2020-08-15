# Create hospital type
hospital_types = ['Rumah Sakit', 'Klinik', 'Klinik Gigi', 'Klinik Kulit & Kecantikan']

hospital_types.each do |name|
  HospitalType.create(name: name)
end
