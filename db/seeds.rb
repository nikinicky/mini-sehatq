# Populate hospital types
hospital_types = ['Rumah Sakit', 'Klinik', 'Klinik Gigi', 'Klinik Kulit & Kecantikan']
hospital_types.each do |name|
  HospitalType.first_or_create(name: name)
end

# Populate doctor specialities
specialities = [
  'Dokter Spesialis Akupunktur', 'Dokter Spesialis Anak', 'Dokter Spesialis Andrologi',
  'Dokter Spesialis Bedah', 'Dokter Spesialis Bedah Anak', 'Dokter Spesialis Bedah Plastik',
  'Dokter Spesialis Penyakit Dalam', 'Fisioterapis', 'Dokter Gigi', 'Ahli Gizi', 
  'Dokter Spesialis Gizi', 'Dokter Spesialis Jantung', 'Dokter Spesialis Kedokteran Jiwa',
  'Dokter Spesialis Kandungan', 'Dokter Spesialis Kulit', 'Dokter Spesialis Mata',
  'Psikolog', 'Dokter Spesialis Saraf', 'Dokter Spesialis THT', 'Dokter Umum'
]
specialities.each do |name|
  DoctorSpeciality.first_or_create(name: name)
end
