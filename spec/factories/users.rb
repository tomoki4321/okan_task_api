FactoryBot.define do
  factory :user do
    name { 'test_user' }
    email { 'test_user@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin {false}
  end
  factory :admin_user ,class: User do
    name { 'admin_user' }
    email { 'admin_user@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin {true}
  end
  factory :user2 ,class: User do
    name { 'user2' }
    email { 'user2@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin {false}
  end
end