require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    unless @columns
      table = DBConnection::execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL

      @columns = table.first.map do |col_name|
        col_name.to_sym
      end
    end

    @columns
  end

  def self.finalize!
    columns.each do |col_name|
      define_method("#{col_name}") do
        attributes[col_name]
      end

      define_method("#{col_name}=") do |value|
        attributes[col_name] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.downcase.pluralize
  end

  def self.all
    parse_all(DBConnection::execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    )
  end

  def self.parse_all(results)
    results.map do |result|
      new(result)
    end
  end

  def self.find(id)
    result = DBConnection::execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = #{id}
    SQL

    result.empty? ? nil : new(result.first)
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      if self.class.columns.include?(attr_name.to_sym)
        self.send(("#{attr_name}=").to_sym, value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |attr_name|
      self.send(("#{attr_name}").to_sym)
    end
  end

  def insert
    col_arr = self.class.columns
    col_names = col_arr.join(", ")
    question_marks = Array.new(col_arr.length) {"?"}
    question_marks = question_marks.join(", ")
    DBConnection::execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.send(:id=, DBConnection.last_insert_row_id)
  end

  def update
    set_line = self.class.columns.map do |attr_name|
      "#{attr_name} = ?"
    end.join(", ")

    DBConnection::execute(<<-SQL, *attribute_values, self.send(:id))
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
       id = ?
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
