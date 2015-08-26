require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_method(("#{name}").to_sym) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]
      p through_options
      p source_options
      t = through_options.table_name
      s = source_options.table_name
      value = self.send(through_options.foreign_key)
      results = DBConnection::execute(<<-SQL, value)
        SELECT
          #{s}.*
        FROM
          #{t}
        JOIN
          #{s}
        ON
          #{s}.#{source_options.primary_key} = #{source_options.foreign_key}
        WHERE
          #{t}.#{through_options.primary_key.to_s} = ?
      SQL
      p results
      results.empty? ? nil : source_options.model_class.new(results.first)
    end
  end
end
