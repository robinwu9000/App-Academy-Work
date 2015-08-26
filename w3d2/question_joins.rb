require_relative 'items'

class QuestionJoin < Item
  attr_reader :id, :question_id, :user_id

  def initialize(data)
    @id = data['id']
    @question_id = data['question_id']
    @user_id = data['user_id']
  end

end

class QuestionLike < QuestionJoin
  def self.tbl_name
    "question_likes"
  end

  def self.likers_for_question_id(question_id)
    rows = db.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_id = ?
    SQL
    rows.map {|row| User.new(row)}
  end

  def self.num_likes_for_question_id(question_id)
    rows = db.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL
    rows.first[0]
  end

  def self.liked_questions_for_user_id(user_id)
    rows = db.execute(<<-SQL, user_id)
      SELECT
        q.*
      FROM
        questions q
      JOIN
        question_likes k ON q.id = k.question_id
      WHERE
        q.user_id = ?
    SQL
    rows.map {|row| Question.new(row)}
  end

  def self.karma_for_user_id(user_id)
    rows = db.execute(<<-SQL, user_id)
      SELECT SUM(X.score)/COUNT(X.id)
      FROM (
        SELECT
          q.id AS "id", COUNT(k.id) AS "score"
        FROM
          questions q
        LEFT JOIN
          question_likes k ON q.id = k.question_id
        WHERE
          q.user_id = ?
        GROUP BY
          q.id
      ) AS X
    SQL
    rows.first[0]
  end

  def self.most_liked_questions(n)
    rows = db.execute(<<-SQL, n)
      SELECT
        q.*
      FROM
        questions q
      LEFT JOIN
        question_likes k ON k.question_id = q.id
      GROUP BY
        q.id
      ORDER BY
        COUNT(k.id) DESC
      LIMIT
        ?
    SQL
    rows.map {|row| Question.new(row)}
  end

end

class QuestionFollow < QuestionJoin
  def self.tbl_name
    "question_follows"
  end

  def self.followers_for_question_id(question_id)
    rows = db.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_follows
      JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_id = ?
    SQL
    rows.map {|row| User.new(row)}
  end

  def self.followed_questions_for_user_id(user_id)
    rows = db.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL
    rows.map {|row| Question.new(row)}
  end

  def self.most_followed_questions(n)
    rows = db.execute(<<-SQL, n)
      SELECT
        q.*
      FROM
        questions q
      LEFT JOIN
        question_follows f ON f.question_id = q.id
      GROUP BY
        q.id
      ORDER BY
        COUNT(f.id) DESC
      LIMIT
        ?
    SQL
    rows.map {|row| Question.new(row)}
  end

end
