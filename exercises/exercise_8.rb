require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'
require_relative './exercise_6'
require_relative './exercise_7'

puts "Exercise 8"
puts "----------"

# Create an employee for an existing store without specifying a password
@store1.employees.create(first_name: "Alice", last_name: "Johnson", hourly_rate: 55)

# Output the password generated by the model
new_employee = @store1.employees.last
puts "Generated Password for #{new_employee.first_name}: #{new_employee.password}"