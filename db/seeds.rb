User.create!(name:  "Dam Tien Hung",
             email: "tienhuzng@gmail.com",
             password: "123123",
             password_confirmation: "123123",
             is_admin: true)

10.times do
  User.create([{
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
  }])
end

users = User.order(:created_at).take(6)

10.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
