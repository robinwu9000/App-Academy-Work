require_relative 'items'
require_relative 'question_joins'

class User < Item
  attr_reader :id, :first_name, :last_name

  def self.tbl_name
    "users"
  end

  def initialize(data)
    @id = data['id']
    @first_name = data['first_name']
    @last_name = data['last_name']
  end

  def first_name=(new_name)
    @first_name = new_name
    save
  end

  def last_name=(new_name)
    @last_name = new_name
    save
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def self.find_by_name(first_name, last_name)
    rows = db.execute(<<-SQL, first_name, last_name)
      SELECT
        *
      FROM
        users
      WHERE first_name = ? AND last_name = ?
    SQL

    self.new(rows.first)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end

  def average_karma
    QuestionLike.karma_for_user_id(id)
  end

  private

  def insert
    db.execute(<<-SQL, first_name, last_name)
      INSERT INTO users (first_name, last_name) VALUES (?, ?)
    SQL
    @id = db.last_insert_row_id
  end

  def update
    db.execute(<<-SQL, first_name, last_name, id)
      UPDATE users
      SET first_name = ?, last_name = ?
      WHERE id = ?
    SQL
  end

end
