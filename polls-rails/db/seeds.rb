# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

num_users = 10
num_users.times do
  usr = User.create!(name: Faker::Name.name)
  if rand(2) == 1
    pl = Poll.create!(
      title: "opinions about #{Faker::Company.name}",
      author_id: usr.id
    )

    (rand(6) + 1 ).times do
      qst = Question.create!(
        body: "How strongly do you identify with #{Faker::Commerce.product_name}",
        poll_id: pl.id
      )

      (rand(3) + 2).times do
        AnswerChoice.create!(
          answer: Faker::Commerce.color,
          question_id: qst.id
        )
      end

    end
  end

end

users = User.pluck(:id)
answer_choices = AnswerChoice.pluck(:id)

10.times do
  Response.create(user_id: users.sample, answer_choice_id: answer_choices.sample)
end
