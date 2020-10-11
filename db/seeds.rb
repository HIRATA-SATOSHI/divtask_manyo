# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password,
              )
end

User.create!(name:  "管理者",
  email: "admin@example.jp",ß
  password:  "11111111",
  password_confirmation: "11111111",
  admin: true)

20.times do |n|
  binding.pry
  name = Faker::Games::Pokemon.name
  detail = Faker::Games::Pokemon.location
  deadline = Faker::Date.between(from: Date.tomorrow, to: 7.days.since)
  status = ["0","1","2"]
  user_id = rand(1..16)
  Task.create!(name: name, detail: detail, deadline: deadline, status: rand(0..2), priority: rand(0..2), user_id: user_id)
end


20.times do |n|
  binding.pry
  label = ["開発", "設計", "テスト"]
  Label.create!(name: label)
end

20.times do |n|
    Labeling.create!(task_id: rand(1..20), label_id: rand(1..16))
end


