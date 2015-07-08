# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Admin member information
Member.create!(username:  "amos",
             email: "picco.cuile@yahoo.com",
             last_name: "Cui",
             first_name: "Le",
             age: 26,
             status: "Single",
             gender: "Male",
             about_me: Faker::Lorem.sentence(7),
             password:              "iloveyou",
             password_confirmation: "iloveyou",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  username  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  lastname = Faker::Name.name
  firstname = Faker::Name.name
  age = rand(20..30)
  status = "Single"
  Member.create!(username:  username,
               email: email,
               last_name: lastname,
               first_name: firstname,
               age: age,
               status: status,
               gender: ["Male", "Female"].sample,
               about_me: Faker::Lorem.sentence(7),
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

members = Member.order(:created_at).take(6)
20.times do
    content = Faker::Lorem.sentence(5)
    members.each { |member| member.timelines.create!(content: content) }
end
