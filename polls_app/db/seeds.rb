# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Question.destroy_all
Poll.destroy_all
AnswerChoice.destroy_all
Response.destroy_all
users = []

10.times do
    users << User.create!(username: Faker::FunnyName.name)
end

polls = []
3.times do
    polls << Poll.create!(author_id: users.sample.id, title: Faker::Marketing.buzzwords )
end

questions = []

polls.each do |poll|
    questions << Question.create!(text: Faker::Marketing.buzzwords, poll_id: poll.id)
end

answers = []
questions.each do |question|
    4.times do 
        answers << AnswerChoice.create!(question_id: question.id, answer: Faker::ChuckNorris.fact )
    end
end


15.times do 

    Response.create!( user_id: users.sample.id, answer_id: answers.sample.id )
end