require_relative '../setup'
require_relative './exercise_1'
require_relative './exercise_2'
require_relative './exercise_3'

puts "Exercise 4"
puts "----------"

# Your code goes here ...

stores = Store.create(name: "Surrey", annual_revenue: 224000, mens_apparel: false, womens_apparel: true)
stores = Store.create(name: "Whistler", annual_revenue: 1900000, mens_apparel: true, womens_apparel: false)
stores = Store.create(name: "Yaletown", annual_revenue: 430000, mens_apparel: true, womens_apparel: true)


@mens_stores = Store.where(mens_apparel: true, womens_apparel: false)


puts "Men's Stores:"

@mens_stores.each do |store|
  puts "Name: #{store.name}, Annual Revenue: #{store.annual_revenue}"
end

@womens_low_revenue_stores = Store.where(womens_apparel: true).where("annual_revenue < ?", 1000000)

# Output women's stores with low revenue
puts "Women's Stores with Annual Revenue < $1M:"
@womens_low_revenue_stores.each do |store|
  puts "Name: #{store.name}, Annual Revenue: #{store.annual_revenue}"
end