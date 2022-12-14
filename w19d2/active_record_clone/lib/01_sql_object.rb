require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      LIMIT (1)
    SQL
    .first.map!(&:to_sym)
  end

  def self.finalize!
    columns.each do |col|
      define_method(col) { attributes[col] }
      
      define_method((col.to_s + '=').to_sym) do |value|
        attributes[col] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...

    list = DBConnection.execute(<<-SQL)
    SELECT
      #{self.table_name}.*
    FROM
      #{self.table_name}  
    SQL
    parse_all(list)
    
  end

  def self.parse_all(results)
    # ...
    list = results.map { |datum| self.new(datum) }
    list
  end

  def self.find(id)
    # ...
    data = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE 
         #{self.table_name}.id = ?
    SQL
      self.new(data.first) if data.first
    
    
  end

  def initialize(params = {})
    # ...
    params.each do |k, v|
      attr_name = k.to_sym 
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name) 
      send("#{k}=".to_sym, v)
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map { |col| send(col) }
    
  end

  def insert
    # ...
    col_names = self.class.columns.join(',')
    question_marks = (['?'] * self.class.columns.count).join(',')

    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    col_names = self.class.columns.map { |col| "#{col} = ?" }.join(',') 

    DBConnection.execute(<<-SQL, *attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...
    if self.id.nil? 
      insert
    else
      update
    end
  end
end
