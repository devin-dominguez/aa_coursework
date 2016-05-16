class Fixnum
  # Fixnum#hash already implemented for you
end
#
class Array
  def hash
    hash_val = 0

    self.each_with_index do |el, i|
      hash_val ^= (el * (i + 1)).hash
    end

    hash_val
  end
end

class String
  def hash
    self.split("").map(&:ord).hash
  end
end

class Hash
  def hash_meth
    hash_num = 0
    self.each do |k, v|
      hash_num ^= [k.to_s.hash, v].hash
    end

    hash_num
  end
end
