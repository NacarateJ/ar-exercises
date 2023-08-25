require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'
require_relative './exercise_4'
require_relative './exercise_5'

puts "Exercise 6"
puts "----------"

# Your code goes here ...

# Creating employees for store1 (BurnabyUpdated)
@store1.employees.create(first_name: "Khurram", last_name: "Virani", hourly_rate: 60)
@store1.employees.create(first_name: "John", last_name: "Doe", hourly_rate: 50)

# Creating employees for store2 (Richmond)
@store2.employees.create(first_name: "Jane", last_name: "Smith", hourly_rate: 55)
@store2.employees.create(first_name: "Mike", last_name: "Johnson", hourly_rate: 65)


@store4 = Store.find_by(id: 4)

# Creating employees for store4 (Surrey)
@store4.employees.create(first_name: "Tom", last_name: "Bennet", hourly_rate: 45)
@store4.employees.create(first_name: "Anne", last_name: "Williams", hourly_rate: 70)


# Display employees for each store
@store1.employees.each do |employee|
  puts "Store: #{employee.store.name}, Employee: #{employee.first_name} #{employee.last_name}"
end

@store2.employees.each do |employee|
  puts "Store: #{employee.store.name}, Employee: #{employee.first_name} #{employee.last_name}"
end

@store4.employees.each do |employee|
  puts "Store: #{employee.store.name}, Employee: #{employee.first_name} #{employee.last_name}"
end