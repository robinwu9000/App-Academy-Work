require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = []
    where_values = []
    params.each do |key, value|
      where_line << "#{key} = ?"
      where_values << value
    end
    where_line = where_line.join(" AND ")
    # p where_line
    # p where_values
    result = DBConnection.execute(<<-SQL, *where_values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL

    result.map do |object|
      self.new(object)
    end
  end
end

class SQLObject
  extend Searchable
end
