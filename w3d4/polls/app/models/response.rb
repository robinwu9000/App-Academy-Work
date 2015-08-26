class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question

  belongs_to(
    :answer_choice,
    :foreign_key => :answer_choice_id,
    :primary_key => :id,
    :class_name => "AnswerChoice"
  )

  belongs_to(
    :respondent,
    :foreign_key => :user_id,
    :primary_key => :id,
    :class_name => "User"
  )

  has_one :question, :through => :answer_choice, :source => :question

  def sibling_responses
    question.responses
    .where("responses.id IS NOT ? AND responses.id IS NOT NULL", self.id)
  end

  def respondent_has_not_already_answered_question
    unless sibling_responses.where("user_id = ?", respondent.id).count < 1
      errors[:base] << "already answered the question"
    end
  end

  def author_cannot_respond_to_own_poll
    question = Question.find(answer_choice.question_id)
    poll = Poll.find(question.poll_id)
    user = User.find(poll.user_id)
    if user_id == user.id
      errors[:author] << "author can't respond to own poll"
    end
  end



end
