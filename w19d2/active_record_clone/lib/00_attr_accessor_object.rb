class AttrAccessorObject

  def self.my_attr_accessor(*names)
    names.each do |key|
      define_method(key) { instance_variable_get('@' + (key.to_s)) }

      setter_name = (key.to_s + '=').to_sym
      define_method(setter_name.to_sym) do |value|
        instance_variable_set('@' + (key.to_s), value)
      end
      
    end
  end
end
