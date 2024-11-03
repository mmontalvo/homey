Message.destroy_all
User.destroy_all

user = User.create(email: "test@test.com", password: "admin123", password_confirmation: "admin123")

4.times do
  Message.create(body: Faker::Lorem.sentence(word_count: 12), user_id: user.id)
end