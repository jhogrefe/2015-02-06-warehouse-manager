require 'pry'

# To initialize and enable our program to run SQLITE3
require 'sqlite3'

# Here, we create the actual database if it's not created yet.
# Otherwise, it will simply load the existing database: 
# ex: DATABASENAME = DATABASEINTERPRETERNAME::Databaseobjectname.new
# ('yourdesired_database_name')

DATABASE = SQLite3::Database.new('warehousemanager.db')

# Here, we load category, location and product files so we don't need to in 
# every file

require_relative "category.rb"
require_relative "location.rb"
require_relative "product.rb"

# CLI menu
puts "-" * 50
puts "WELCOME TO THE WAREHOUSE MANAGER INVENTORY MANAGEMENT SYSTEM"
puts "-" * 50
puts
puts "Please choose an option below to begin."
puts
puts "PRODUCT MANAGER"
puts "-" * 50
puts "1 - Add a new product."
puts "2 - Update a current product."
puts "3 - Delete a current product."
puts "4 - Fetch current product list."
puts "5 - Update product quantity."
puts
puts "WAREHOUSE LOCATION MANAGER"
puts "-" * 50
puts "6 - Fetch current warehouse location list."
puts "7 - Add a new location."
puts "8 - Update a current location."
puts "9 - Delete a current location."
puts "10 - Assign a product to a location."
puts
puts "PRODUCT CATEGORY MANAGER"
puts "-" * 50
puts "11 - Fetch current product category list."
puts "12 - Assign a product to a category."
puts
puts "Enter number here: "
answer = gets.chomp.to_i


binding.pry