json.partial! 'api/v1/doctors/doctors', locals: { 
  doctor: @doctor, 
  show_schedules: true, 
  schedules: @schedules 
}
