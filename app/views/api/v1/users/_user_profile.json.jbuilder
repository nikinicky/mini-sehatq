json.user do
  json.id user.id
  json.full_name user.full_name
  json.email user.email
  json.birthday user.birthday
  json.age user.age
  json.gender user.gender
  json.is_doctor user.is_doctor
  json.token user_token.token
end
