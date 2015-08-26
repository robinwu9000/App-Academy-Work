require_relative 'items'
require_relative 'question_joins'

class Question < Item
  attr_reader :id, :title, :user_id, :body

  def self.tbl_name
    "questions"
  end

  def initialize(data)
    @id = data['id']
    @title = data['title']
    @user_id = data['user_id']
    @body = data['body']
  end

  def self.find_by_author_id(author_id)
    rows = db.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    rows.map {|row| self.new(row)}
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def likers
    QuestionLike.likers_for_question_id(id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(id)
  end

end
