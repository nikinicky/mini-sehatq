json.hospitals @hospitals do |hospital|
  show_schedules = show_schedules || nil
  json.partial! 'api/v1/hospitals/hospitals', locals: { hospital: hospital, show_schedules: show_schedules }
end
