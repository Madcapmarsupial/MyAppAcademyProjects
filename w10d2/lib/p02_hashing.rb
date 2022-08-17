class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash

    val = 0
     self.each_with_index do |ele, i|
      val += ((ele.hash) * i )
    end
    val.hash
  end
end

class String
  def hash
    sum = 0
    alpha = ("a".."z").to_a
    chars = self.split("")
    chars.each_with_index do |char, i|
      j = alpha.find_index(char)
      sum += j.hash * i
    end 
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    key_str = self.keys.join(":").split(":").sort
    values = self.values.sort
    output = (values + key_str).hash
    return output if output != nil

    0
  end
end
