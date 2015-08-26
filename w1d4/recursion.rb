require 'byebug'

def range(start,finish)
  return [] if finish < start
  array = range(start + 1, finish - 1)
  array.unshift(start)
  array << finish
end

def sum_iterative(array)
  sum = 0
  array.each do |x|
    sum += x
  end
  sum
end

def sum_recursive(array)
  return array.last if array.length == 1
   array.pop + sum_recursive(array)
end

def exp(num, pow, count)
  return 1 if pow == 0
  num * exp(num, pow - 1)
end

def exp_2(num, pow)
  return 1 if pow == 0
  if pow % 2 == 0
    exp_2(num, pow/2) ** 2
  else
    num * (exp_2(num, (pow - 1) / 2) ** 2)
  end
end

class Array
  def deep_dup
    return self.dup if self.none? { |el| el.is_a?(Array) }
    self.map do |el|
      if el.is_a?(Array)
        el.deep_dup
      else
        el#.is_a?(Fixnum) ? el : el.dup
      end
    end
  end
end

def fib_recursive(num)
  return [0] if num == 1
  return [0,1] if num == 2
  arr = fib_recursive(num-1)
  arr << arr[-2] + arr[-1]
end

def fib_iterative(num)
  result = [0]
  next_number = 1
  until result.length == num
    result << next_number
    next_number = result[-2] + result[-1]
  end
  result
end

def bsearch(array, target)
  index = array.length / 2
  if array[index] == target
    index
  elsif array.length <= 1 || array == nil || array.empty?
    nil
  elsif array[index] < target
    sub_search = bsearch(array[index+1..-1], target)
    if sub_search.nil?
      nil
    else
      sub_search + index + 1
    end
  else
    return (bsearch(array[0..index-1], target)) || nil
  end
end

def make_change(amount, coins)
  max_count = Array.new(amount, 1)
  permute = coins.permutation(coins.length)
  permute.each do |possible|
    return Array.new(amount/possible[0],possible[0]).flatten if coins.length == 1
    num_coins = amount / possible[0]
    left = amount - possible[0]  * num_coins
    change = make_change(left, possible.drop(1)).flatten
    a = change.unshift(Array.new(num_coins, possible[0])).flatten
    max_count = a if max_count.length > a.length
  end

  max_count
end

def merge_sort(array)
  if array.length <= 1
    return array
  end
  midpoint = (array.length-1)/2
  arr1 = merge_sort(array[0..midpoint])
  arr2 = merge_sort(array[midpoint+1..-1])
  merge(arr1, arr2)
end

def merge(arr1,arr2)
  result = []
  until arr1.empty? && arr2.empty?
    if arr1.empty?
      result << arr2.shift
    elsif arr2.empty?
      result << arr1.shift
    elsif arr1[0] < arr2[0]
      result << arr1.shift
    else
      result << arr2.shift
    end
  end
  result
end

p merge_sort([3,5,2,5,7,9,5,2,1,4,5,2])
