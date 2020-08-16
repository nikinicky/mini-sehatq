# Populate hospital types
hospital_types = ['Rumah Sakit', 'Klinik', 'Klinik Gigi', 'Klinik Kulit & Kecantikan']
hospital_types.each do |name|
  HospitalType.where(name: name).first_or_create!
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
  DoctorSpeciality.where(name: name).first_or_create!
end

# Populate hospitals
rumah_sakit = HospitalType.find_by(name: 'Rumah Sakit')
klinik_gigi = HospitalType.find_by(name: 'Klinik Gigi')
klinik_kecantikan = HospitalType.find_by(name: 'Klinik Kulit & Kecantikan')

hospitals = [
  OpenStruct.new(name: 'Youth Beauty Clinic', district: 'Mampang Prapatan, Jakarta Selatan', open_hours: 'Senin - Sabtu 10:00 - 17:00', support_emergency: false, hospital_type_id: klinik_kecantikan.id),
  OpenStruct.new(name: 'RS Yadika Kebayoran Lama', district: 'Kebayoran Lama, Jakarta Selatan', open_hours: 'Senin - Minggu 00:00 - 23:59', support_emergency: true, hospital_type_id: rumah_sakit.id),
  OpenStruct.new(name: 'Klinik Gigi With Smile', district: 'Kebayoran Baru, Jakarta Selatan', open_hours: 'Senin - Minggu 10:00 - 21:00', support_emergency: false, hospital_type_id: klinik_gigi.id),
  OpenStruct.new(name: 'RS Tebet', district: 'Tebet, Jakarta Selatan', open_hours: 'Senin - Minggu 00:00 - 23:59', support_emergency: true, hospital_type_id: rumah_sakit.id),
  OpenStruct.new(name: 'RS Setia Mitra', district: 'Cilandak, Jakarta Selatan', open_hours: 'Senin - Minggu 00:00 - 23:59', support_emergency: true, hospital_type_id: rumah_sakit.id),
  OpenStruct.new(name: 'Siloam Hospitals Asri', district: 'Pancoran, Jakarta Selatan', open_hours: 'Senin - Sabtu 08:00 - 20:00', support_emergency: true, hospital_type_id: rumah_sakit.id),
  OpenStruct.new(name: 'RS Pondok Indah (RSPI) - Pondok Indah', district: 'Kebayoran Lama, Jakarta Selatan', open_hours: 'Senin - Sabtu 08:00 - 20:00', support_emergency: true, hospital_type_id: rumah_sakit.id),
  OpenStruct.new(name: 'RS Pusat Pertamina', district: 'Kebayoran Baru, Jakarta Selatan', open_hours: 'Senin - Minggu 00:00 - 23:59', support_emergency: true, hospital_type_id: rumah_sakit.id)
]
hospitals.each do |hospital|
  Hospital.where(name: hospital.name).first_or_create!(
    district: hospital.district,
    open_hours: hospital.open_hours,
    support_emergency: hospital.support_emergency,
    hospital_type_id: hospital.hospital_type_id
  )
end

# Populate Doctors
doctors = [
  OpenStruct.new(name: 'drg. Andrian Nova Fitri, Sp.PM', email: 'andrian@mail.com', password: 'sehatq', gender: 'male', birthday: '1990-06-17', is_doctor: true, hospital_name: ['RS Pusat Pertamina'], speciality_id: 9),
  OpenStruct.new(name: 'dr. Tri Wahyu Setyaningsih, Sp.M', email: 'triwahyu@mail.com', password: 'sehatq', gender: 'female', birthday: '1990-06-17', is_doctor: true, hospital_name: ['RS Pusat Pertammina', 'RS Tebet'], speciality_id: 16),
  OpenStruct.new(name: 'dr. Siselia Titis Iramawati', email: 'titis@mail.com', password: 'sehatq', gender: 'female', birthday: '1990-06-17', is_doctor: true, hospital_name: ['RS Pusat Pertamina', 'RS Pondok Indah (RSPI) - Pondok Indah'], speciality_id: 20),
  OpenStruct.new(name: 'dr. RR. Fika Tiara Wahyu Widayati, Sp.S', email: 'fika@mail.com', password: 'sehatq', gender: 'female', birthday: '1990-06-17', is_doctor: true, hospital_name: ['RS Yadika Kebayoran Lama'], speciality_id: 18),
  OpenStruct.new(name: 'drg. Vina Carolina', email: 'vina@mail.com', password: 'sehatq', gender: 'female', birthday: '1990-06-17', is_doctor: true, hospital_name: ['Klinik Gigi With Smile'], speciality_id: 9)
]
doctors.each do |doctor|
  object_doctor = User.where(email: doctor.email).first_or_create!(
    full_name: doctor.name,
    password: doctor.password,
    gender: doctor.gender,
    birthday: doctor.birthday,
    is_doctor: doctor.is_doctor
  )

  if object_doctor.persisted?
    hospital_ids = Hospital.where(name: doctor.hospital_name).pluck(:id) || [Hospital.last.id]
    DoctorInformation.where(doctor_id: object_doctor.id).first_or_create!(
      hospital_ids: hospital_ids,
      speciality_id: doctor.speciality_id
    )
  end
end

# Populate Doctor Schedule
schedule_date = (DateTime.now + 7.days).strftime('%Y-%m-%d')
schedule_hours = [
  {start_hour: '09:00', end_hour: '09:20'},
  {start_hour: '09:30', end_hour: '09:50'},
  {start_hour: '10:00', end_hour: '10:20'},
  {start_hour: '10:30', end_hour: '10:50'},
  {start_hour: '11:00', end_hour: '11:20'},
  {start_hour: '11:30', end_hour: '11:50'},
  {start_hour: '13:00', end_hour: '13:20'},
  {start_hour: '13:30', end_hour: '13:50'},
  {start_hour: '14:00', end_hour: '14:20'},
  {start_hour: '14:30', end_hour: '14:50'},
  {start_hour: '15:00', end_hour: '15:20'},
]
User.where(is_doctor: true).each do |doctor|
  hospital = doctor.doctor_information.hospitals.first
  schedule_hours.each do |schedule|
    DoctorSchedule.where(
      doctor_id: doctor.id, 
      hospital_id: hospital.id, 
      date: schedule_date, 
      start_hour: schedule[:start_hour], 
      end_hour: schedule[:end_hour]).first_or_create!()
  end
end
