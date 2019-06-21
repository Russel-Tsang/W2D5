class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    h = ""
    self.each do |i|
      h += (i * 2).to_s
    end
    h.to_i 
  end
end

class String
  def hash
    self.split("").map{|char| char.ord}.join("").to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # return 0 if nil?
    h = 0
    self.to_a.flatten.each do |ele|
      h += ele.hash
    end
    return h
    # 0
  end
end
