class Array
  def my_uniq
    uniq_el = []
    self.each {|el| uniq_el << el unless uniq_el.include?(el)}
    uniq_el
  end

  def two_sum
    results = []
    (0...length-1).each do |i|
      (i+1...length).each do |j|
        results << [i,j] if (self[i] + self[j]) == 0
      end
    end
    results
  end

  def median
    raise "Can't use an empty array" if empty?
    return self.sort[length / 2] if length.odd?
    middle_two = self.sort[((length / 2) - 1)..(length / 2)]
    (middle_two.first + middle_two.last) / 2
  end

  def my_transpose
    result = Array.new(length) {Array.new{length}}
    (0...length).each do |i|
      (0...length).each do |j|
        self[i][j], self[j][i] = self[j][i], self[i][j]
      end
    end
    self
    # result
  end
end
