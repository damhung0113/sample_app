User.create!(name:  "Dam Tien Hung",
             email: "tienhuzng@gmail.com",
             password: "123123",
             password_confirmation: "123123",
             is_admin: true)

30.times do |i|
  User.create!(
    name: Faker::Name.name,
    email: "sampleapp123123-#{i}@gmail.com",
    password: "123123"
  )
end

users = User.order(:created_at).take(6)

10.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
