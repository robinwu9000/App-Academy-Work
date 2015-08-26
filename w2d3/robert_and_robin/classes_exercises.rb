class Employee
  attr_reader :name, :title, :salary, :boss, :employees

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
    @employees = []
  end

  def bonus(multiplier)
    salary * multiplier
  end
end

class Manager < Employee
  attr_accessor :employees

  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_salary = 0
    queue = employees
    until queue.empty?
      current = queue.shift
      total_salary += current.salary
      queue.concat(current.employees)
    end
    total_salary * multiplier
  end
end

ned = Manager.new("ned", "founder", 1000000, nil, [])
darren = Manager.new("darren", "ta manager", 78000, ned, [])
david = Employee.new("david", "ta", 10000, darren)
shawna = Employee.new("shawna", "ta", 12000, darren)
ned.employees = [darren]
darren.employees = [david, shawna]

p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
