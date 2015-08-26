class Question < ActiveRecord::Base
  validates :question_text, :poll_id, presence: true

  has_many(
    :answer_choices,
    :foreign_key => :question_id,
    :primary_key => :id,
    :class_name => "AnswerChoice"
  )

  belongs_to(
    :poll,
    :foreign_key => :poll_id,
    :primary_key => :id,
    :class_name => "Poll"
  )

  has_many :responses, :through => :answer_choices, :source => :responses

  def results
    ac_arr = answer_choices.includes(:responses)
    count_hash = {}
    ac_arr.each do |ac|
      count_hash[ac.answer_choice_text] = ac.responses.length
    end
    count_hash
  end
end
