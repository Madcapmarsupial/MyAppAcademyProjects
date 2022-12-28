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
    # ...
    self.class_name.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    @name = name.to_s.camelcase.singularize.underscore
    @primary_key = (options[:primary_key] || :id)
    @foreign_key = (options[:foreign_key] || "#{name.to_s.singularize}_id".to_sym)
    @class_name = (options[:class_name] || name.to_s.singularize.capitalize)
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    @name = self_class_name
    @class_name = options[:class_name] || name.to_s.singularize.capitalize
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] || "#{self_class_name.to_s.singularize.downcase}_id".to_sym
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, params = {})
    # ...
    options = BelongsToOptions.new(name, params)
    self.assoc_options[name] = options
     define_method(name) {
       fkey = send(options.foreign_key)
       options.model_class
       .where({options.primary_key => fkey}).first
     }
  end

  def has_many(name, params = {})
    # ...
     options = HasManyOptions.new(name, self.to_s, params)
     define_method(name) {
       fkey = send(options.primary_key)
       options.model_class
       .where({options.foreign_key => fkey})
     }
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
