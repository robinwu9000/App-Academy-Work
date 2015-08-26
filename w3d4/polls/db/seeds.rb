# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

a = User.create!(user_name: "Andrew")
b = User.create!(user_name: "Bob")
c = User.create!(user_name: "Catherine")
d = User.create!(user_name: "David")
e = User.create!(user_name: "Emma")

p1 = Poll.create!(title: "Sample 1", user_id:a.id)
q1 = Question.create!(question_text: "Where should I eat?", poll_id: p1.id)
ac1 = AnswerChoice.create!(answer_choice_text: "a", question_id: q1.id)
ac2= AnswerChoice.create!(answer_choice_text: "b", question_id: q1.id)
ac3= AnswerChoice.create!(answer_choice_text: "c", question_id: q1.id)
q2 = Question.create!(question_text: "What color is your car?", poll_id: p1.id)
ac4 = AnswerChoice.create!(answer_choice_text: "d", question_id: q2.id)
ac5 = AnswerChoice.create!(answer_choice_text: "e", question_id: q2.id)
ac6 = AnswerChoice.create!(answer_choice_text: "f", question_id: q2.id)
q3 = Question.create!(question_text: "How many cats do you have?", poll_id: p1.id)
ac7 =AnswerChoice.create!(answer_choice_text: "g", question_id: q3.id)
ac8 = AnswerChoice.create!(answer_choice_text: "h", question_id: q3.id)


p2 = Poll.create!(title: "Sample 2", user_id:c.id)
q4 = Question.create!(question_text:"Q4", poll_id:p2.id)
ac9 = AnswerChoice.create!(answer_choice_text: "i", question_id: q4.id)
ac10 = AnswerChoice.create!(answer_choice_text: "j", question_id: q4.id)
ac11 = AnswerChoice.create!(answer_choice_text: "k", question_id: q4.id)
q5 = Question.create!(question_text:"Q5", poll_id:p2.id)
ac12 =AnswerChoice.create!(answer_choice_text: "l", question_id: q5.id)
q6 = Question.create!(question_text:"Q6", poll_id:p2.id)
ac13 = AnswerChoice.create!(answer_choice_text: "m", question_id: q6.id)
ac14 = AnswerChoice.create!(answer_choice_text: "n", question_id: q6.id)

r1 = Response.create!(user_id:e.id, answer_choice_id: ac5.id)
r2 = Response.create!(user_id:b.id, answer_choice_id: ac2.id)
r3 = Response.create!(user_id:e.id, answer_choice_id: ac11.id)
r4 = Response.create!(user_id:a.id, answer_choice_id: ac13.id)
r5 = Response.create!(user_id:d.id, answer_choice_id: ac9.id)
