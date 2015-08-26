require_relative 'questions_db'

class Item
  def self.db
    QuestionsDatabase::instance
  end

  def db
    self.class.db
  end

  def self.tbl_name
    raise NotImplementedError
  end

  def self.find_by_id(id)
    data = db.execute(<<-SQL, id)
      SELECT *
      FROM #{self.tbl_name}
      WHERE id = ?
    SQL
    self.new(data.first)
  end

  def ==(other)
    self.class == other.class && self.id == other.id
  end

  def save
    id ? update : insert
  end

  protected

  def update
    raise NotImplementedError
  end

  def insert
    raise NotImplementedError
  end

  def self.find_by_fieldname(field_name, value)
    rows = db.execute(<<-SQL, value)
      SELECT *
      FROM #{self.tbl_name}
      WHERE #{field_name} = ?
    SQL
    rows.map {|row| self.new(row)}
  end

end
