require_relative 'items'

class Reply < Item
  attr_reader :id, :question_id, :parent_id, :user_id, :body

  def self.tbl_name
    "replies"
  end

  def initialize(data)
    @id = data['id']
    @question_id = data['question_id']
    @parent_id = data['parent_id']
    @user_id = data['user_id']
    @body = data['body']
  end

  def self.find_by_user_id(user_id)
    self.find_by_fieldname('user_id', user_id)
  end

  def self.find_by_question_id(question_id)
    self.find_by_fieldname('question_id', question_id)
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    parent_id ? Reply.find_by_id(parent_id) : nil
  end

  def child_replies
    self.class.find_by_fieldname('parent_id', id)
  end

end
