FactoryBot.define do
  factory :user do
    # id { 1 }
    name { 'test_user_01' }
    email { 'test_user_01@test.com' }
    password { '12345678' }
    admin { false }
  end
  factory :second_user, class: User do
    # id { 2 }
    name { 'test_user_02' }
    email { 'test_user_02@test.com' }
    password { '87654321' }
    admin { true }
  end
end