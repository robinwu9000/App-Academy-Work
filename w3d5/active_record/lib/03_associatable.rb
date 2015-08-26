require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    return "humans" if class_name == "Human"
    class_name.downcase.tableize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @primary_key = options[:primary_key]
    @primary_key ||= :id

    @foreign_key = options[:foreign_key]
    @foreign_key ||= ("#{name.to_s.underscore.downcase}_id").to_sym

    @class_name = options[:class_name]
    @class_name ||= name.camelcase.singularize
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key]
    @primary_key ||= :id


    @foreign_key = options[:foreign_key]
    # p self_class_name
    @foreign_key ||= ("#{self_class_name}_id").downcase.underscore.to_sym
    @foreign_key ||= ("#{name.to_s.underscore.downcase}_id").to_sym

    @class_name = options[:class_name]
    @class_name ||= name.camelcase.singularize
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name.to_s, options)
    assoc_options[name.to_sym] = options
    p assoc_options
    define_method(("#{name}").to_sym) do
      f_key = options.foreign_key
      f_value = self.send(f_key)
      class_name = options.table_name
      results = DBConnection::execute(<<-SQL, f_value)
        SELECT
          *
        FROM
          #{class_name}
        WHERE
          #{options.primary_key.to_s} = ?
      SQL
      results.empty? ? nil : options.model_class.new(results.first)
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self, options)
    define_method(("#{name.to_s}").to_sym) do
      f_key = options.foreign_key
      p "foreign_key is #{f_key}, is a #{f_key.class}, #{options.model_class}"
      f_value = self.send(options.primary_key)
      class_name = options.table_name
      puts class_name
      results = DBConnection::execute(<<-SQL, f_value)
        SELECT
          *
        FROM
          #{class_name}
        WHERE
          #{f_key.to_s} = ?
      SQL
      results.empty? ? [] : results.map {|r| options.model_class.new(r)}
    end
  end

  def assoc_options
    @assoc_options ||= Hash.new
    # @assoc_options =
  end
end

class SQLObject
  extend Associatable
end
