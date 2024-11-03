User.destroy_all
Project.destroy_all
Message.destroy_all
Audit.destroy_all

user = User.create(email: "test@test.com", password: "admin123", password_confirmation: "admin123")

project = Project.create(title: 'First project')
