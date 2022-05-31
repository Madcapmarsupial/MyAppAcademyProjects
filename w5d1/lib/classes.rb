class Employee
    def initialize(name, title, salary, boss)
        @name, @title, @salary, @boss = name, title, salary, boss
    end

    def bonus(multiplier)
        bonus = (salary) * multiplier
    end
    attr_reader :name, :title, :salary, :boss

    def inspect
        {
            "name" => name
        }
    end

end


class Manager < Employee
    def initialize(name, title, salary, boss=nil, *sub_employees)
        super(name, title, salary, boss)
        @sub_employees = sub_employees
    end

    attr_reader :sub_employees
    def bonus(multiplier)
        salaries = @sub_employees.map(&:salary) 
        bonus = (salaries.sum * multiplier)
    end

    def add_sub_employees(*employees)
        employees.each do |employee| 
            if employee.class == Manager
                @sub_employees << employee
                @sub_employees += employee.sub_employees
            else 
                @sub_employees << employee
            end
        end

        
    end

    def inspect
        {
            "name" => name,
            "employees" => @sub_employees
        }
    end
end

ned = Manager.new("Ned", "Founder", 1000000)
darren = Manager.new("Darren", "TA Manager", 78000, ned)
shawna = Employee.new("Shawna", "TA", 12000, darren)
david = Employee.new("David", "TA", 10000, darren)
darren.add_sub_employees(shawna, david)
ned.add_sub_employees(darren)


p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)