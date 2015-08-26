# Jesse Latimer & Robin Wu

require 'set'

class Keypad
  attr_accessor :code_length, :mode_keys, :key_presses


  def initialize(code_length, mode_keys)
    @code_length = code_length
    @mode_keys = mode_keys
    @key_history = []
    @code_bank = Set.new
    @key_presses = 0
  end

  def press(key)
    @key_history << key
    @key_presses += 1
    if @key_history.length > @code_length
      if mode_keys.include?(key)
        #p @key_history[-(@code_length + 1)..-2] unless @code_bank.include?(@key_history[-(@code_length + 1)..-2])
        @code_bank << @key_history[-(@code_length + 1)..-2]
      end
    end
  end

  def all_codes_entered?
    @code_bank.size == 10 ** code_length
  end

  def print_codes
    @code_bank.each do |code|
      p code
    end
    puts "Combo count: #{@code_bank.size}"
  end

end


class KeypadTester

  def initialize(code_length = 4, mode_keys = [1,2,3])
    @code_length = code_length
    @mode_keys = mode_keys
    @keypad_instance = Keypad.new(@code_length, @mode_keys)
  end

  def run_brute_force
    i = 0
    until @keypad_instance.all_codes_entered? do
      current_code = i.to_s.rjust(@code_length, "0").split("").map(&:to_i)
      current_code.each do |key|
        @keypad_instance.press(key)
      end
      @keypad_instance.press(@mode_keys[0])
      i += 1
    end
    @keypad_instance.print_codes
    puts "Key presses: #{@keypad_instance.key_presses}"
  end

  def run_better
    dup_set = get_dup_set
    i = 0
    until @keypad_instance.all_codes_entered? do
      current_code = i.to_s.rjust(@code_length, "0").split("").map(&:to_i)
      if dup_set.include?(current_code)
        i += 1
        next
      end
      current_code.each do |key|
        @keypad_instance.press(key)
      end
      @keypad_instance.press(@mode_keys[0])
      i += 1
    end
    @keypad_instance.print_codes
    puts "Key presses: #{@keypad_instance.key_presses}"
  end

  def get_dup_set
    i = 1
    dup_set = Set.new
    until i > (10 ** @code_length)
      dup_set << i.to_s.rjust(@code_length, "0").split("").map(&:to_i)
      i += 10
    end
    dup_set
  end


  def run_optimizer
    i = 0
    codes_left = []
    while i < (10 ** @code_length)
      codes_left << i.to_s.rjust(@code_length, "0").split("").map(&:to_i)
      i += 1
    end

    until @keypad_instance.all_codes_entered? || codes_left.empty? do
      current_code = codes_left.shift
      current_code.each do |key|
        @keypad_instance.press(key)
      end
      @keypad_instance.press(@mode_keys[rand(@mode_keys.length)])

      current_code = current_code[-(@code_length - 1)..-1] << @mode_keys[rand(@mode_keys.length)]
      while codes_left.include?(current_code) do
        puts current_code.inspect
        @keypad_instance.press(@mode_keys[rand(@mode_keys.length)])
        codes_left.delete(current_code)
        current_code = current_code[-(@code_length - 1)..-1] << @mode_keys[rand(@mode_keys.length)]
      end
    end

    @keypad_instance.print_codes
    puts "Key presses: #{@keypad_instance.key_presses}"
  end

end

a = Time.now
k = KeypadTester.new(3)
k.run_better
puts Time.now - a
