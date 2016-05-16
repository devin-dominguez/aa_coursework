# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

50.times do
  name = Faker::Internet.user_name
  User.create!(username: name, password: 123456)
end

user_ids = User.all.pluck(:id)
10.times do
  Sub.create!({
    moderator_id: user_ids.sample,
    title: Faker::Company.buzzword,
    description: Faker::Hacker.say_something_smart
  })
end
