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
  email: "admin@example.jp",
  password:  "11111111",
  password_confirmation: "11111111",
  admin: true)

20.times do |n|
  name = Faker::Games::Pokemon.name
  detail = Faker::Games::Pokemon.location
  deadline = Faker::Date.between(from: Date.tomorrow, to: 7.days.since)
  status = ["0","1","2"]
  user_id = rand(1..16)
  Task.create!(name: name, detail: detail, deadline: deadline, status: rand(0..2), priority: rand(0..2), user_id: user_id)
end


Label.create!(
  name: '開発'
)

Label.create!(
  name: '設計'
)

Label.create!(
  name: 'テスト'
)

20.times do |n|
    Labeling.create!(task_id: rand(1..20), label_id: rand(1..3))
end


