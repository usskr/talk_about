User.create!(name:  "tatata",
             email: "tatata@example.com",
             password: "tatata",
             password_confirmation: "tatata")

10.times do |n|
  name  = Faker::JapaneseMedia::OnePiece.character
  email = "test-#{n+1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end