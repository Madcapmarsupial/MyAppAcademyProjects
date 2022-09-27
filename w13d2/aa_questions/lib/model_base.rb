require_relative 'questions_database.rb'
require 'active_support/inflector'

class ModelBase
  def self.table
    self.to_s.tableize
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT *
      FROM  #{table}
      WHERE id = ?
    SQL

   self.new(*data)
  end

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM #{table}")
    parse(data)
  end

  def attrs
    Hash[instance_variables.map do |name|
      [name.to_s[1..-1], instance_variable_get(name)]
    end]
  end 

  def save
    raise "#{self} already in database" if self.id 
    instance_attrs = attrs
    instance_attrs.delete("id")
    vals = instance_attrs.values
    cols = instance_attrs.keys.join(", ")
    q_marks = Array.new(instance_attrs.count) {"?"}.join(", ")

    QuestionsDatabase.instance.execute(<<-SQL, *vals)
      INSERT INTO
        #{self.class.table} (#{cols})
      VALUES
      (#{q_marks})
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end
    
  def self.where(options)

    if options.is_a?(Hash)
      where_line = options.keys.map { |key| "#{key} = ?"}.join(" AND ") 
      vals = options.values
    else
      vals = []
      where_line = options
    end

    data = QuestionsDatabase.instance.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{self.table}
      WHERE
        #{where_line}
    SQL

    parse(data)
  end 

  def self.find_by(params)
    self.where(params)
  end


 

  def self.parse(data)
    data.map { |datum| self.new(datum) }
  end

end
