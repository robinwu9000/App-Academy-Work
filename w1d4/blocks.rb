class Array
  def my_each(&blk)
    i = 0
    while i < self.length do
      blk.call(self[i])
      i+=1
    end
  end

  def my_map(&blk)
    result = []
    self.my_each { |x| result << blk.call(x)}
    result
  end

  def my_select(&blk)
    result = []
    self.my_each {|x| result << x if blk.call(x) == true }
    result
  end

  def my_inject(&blk)
    result = self[0]
    self.drop(1).my_each {|x| result = blk.call(result,x)}
    result
  end

  def my_sort!(&blk)
    self.length.times do
      i = 0
      while i < self.length - 1 do
        if blk.call(self[i], self[i + 1]) == 1
          self[i], self[i + 1] = self[i+1], self[i]
        end
        i += 1
      end
    end
    return self
  end

  def my_sort(&blk)
    duplicate = self.dup
    duplicate.my_sort!(&blk)
  end

end

def eval_block(*args, &blk)
  if !block_given?
    puts "No block given"
    return
  end

  blk.call(*args)
end

# a = (1..100).to_a.my_find { |i| i % 5 == 0 and i % 7 == 0 }
# p a

eval_block("Kerry", "Washington", 23) do |fname, lname, score|
  puts "#{lname}, #{fname} won #{score} votes."
end

p eval_block(1,2,3,4,5) { |*args| args.inject(:+) }
