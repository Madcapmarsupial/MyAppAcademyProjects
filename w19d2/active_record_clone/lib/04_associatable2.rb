require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    # ...
      
    define_method(name) {
      through_options = self.class.assoc_options[through_name]
      source_options =
        through_options.model_class.assoc_options[source_name]

      r_table = through_options.table_name
      r_foreign_key = source_options.foreign_key
      r_id = through_options.primary_key

      l_foreign_key = through_options.foreign_key
      l_table = source_options.table_name
      l_id = source_options.primary_key
      source_type = source_options.class_name.constantize

      data = DBConnection.execute(<<-SQL, self.id)
      SELECT
        #{l_table}.*
      FROM
        #{r_table}
      JOIN
        #{l_table} ON #{r_table}.#{r_foreign_key} = #{l_table}.#{l_id}
      WHERE
        #{r_table}.#{r_id} = ?     
      SQL

      data.map!{ |datum| source_type.new(datum) }.first 
    }

  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end