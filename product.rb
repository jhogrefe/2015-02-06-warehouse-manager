# Public: Product
# A class to get and set values in the 'products' database table.
#
# Attributes:
# id, name, location_id, category_id, description, cost, serial, quantity.
#
# Methods:
# #insert, #save, #delete, #fetch_product_record
class Product
  attr_reader :id
  attr_accessor :name, :location_id, :category_id, :description, 
                :cost, :serial, :quantity

  def initialize(options)
    @name        = options["name"]
    @id          = options["id"]
    @location_id = options["location_id"]
    @category_id = options["category_id"]
    @description = options["description"]
    @cost        = options["cost"]
    @serial      = options["serial"]
    @quantity    = options["quantity"]
  end
  
  
  #### 
  # I LIKE OUR INSERT METHOD HERE (ALTHOUGH IT IS ESSENTIALLY COPIED FROM WHAT 
  # SUMEET DID IN HIS STUDENT EXAMPLE). IT IS COMPLETELY FUNCTIONAL, DOES ONE
  # THING, AND I DO NOT SEE ANY WAY TO IMPROVE IT.
  ####
  
  # Public: #insert
  # Adds the object to the 'products' table as a new product record and 
  # assigns an id.
  #
  # Parameters:
  # Any attribute value given by the user, including name, location_id,
  # category_id, description, cost, serial, quantity
  #
  # Returns: Integer,
  #
  # State Changes:
  # Inserts values into 'products' table in the database as a new product
  # record.
  def insert
    
    DATABASE.execute("INSERT INTO products (name, location_id, category_id,
                      description, cost, serial, quantity) 
                      VALUES ('#{name}', #{location_id}, #{category_id}, 
                      '#{description}', #{cost}, '#{serial}', #{quantity})")
    @id = DATABASE.last_insert_row_id
  end
  
  # Public: #save
  # Take all the attributes for this object and make sure those are the 
  # values in this object's corresponding row in the 'students' table.
  #
  # Parameters:
  # instance_variables - value of each instance variable that is set by
  #                      the user.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Sets the new values in the database.
  def save
    get_product = []

    instance_variables.each do |x|
      get_product << x.to_s.delete("@")
  
    end
    
    product_grabber = []
    
    get_product.each do |y|
      local_var = self.send(y)
    
      if local_var.is_a?(Integer)
        product_grabber << "#{y} = #{local_var}"  
      else
        product_grabber << "#{y} = '#{local_var}'"
      end
    end
    
    var = product_grabber.join(", ")
    
    DATABASE.execute("UPDATE products SET #{var} WHERE id = #{id}")
  end
  
  
  # Public: #delete
  # Returns the current values in the database as an array and deletes the 
  # product record for any matching name given by the the user.
  #
  # Parameters:
  # instance_variables - value of each instance variable that is set by
  #                      the user.
  #
  # Returns:
  # None.
  #
  # State Changes:
  # Removes the product record from the database.  
  def delete
    get_product = []

    instance_variables.each do |x|
      get_product << x.to_s.delete("@")
  
    end
    
    product_grabber = []
    
    get_product.each do |y|
      local_var = self.send(y)
    
      if local_var.is_a?(Integer)
        product_grabber << "#{y} = #{local_var}"  
      else
        product_grabber << "#{y} = '#{local_var}'"
      end
    end
    
    var = product_grabber.join(", ")
    
    DATABASE.execute("DELETE FROM products WHERE name = '#{name}'")
  end
  
  # Public: .fetch_product_record
  # A class method to fetch a given record from the 'products' table.
  #
  # Parameters:
  # number - Integer, the student's id in the table.
  #
  # Returns:
  # Array, containing just one row as a hash.
  def self.fetch_product_record(number)
    results = DATABASE.execute("SELECT * FROM products WHERE id = 
                                #{number}")
    #results should only return one position in the array since we're 
    #only requesting one variable:

    return results[0]
  end

  ####
  # A METHOD I THINK WE CAN IMPROVE ON IS THE WAY WE ASSIGN PRODUCTS TO A LOCATION (AND CATEGORY). ALTHOUGH OURS IS FUNCTIONAL, IT IS 100 PERCENT MANUAL AND CAN BE BROKEN EASILY BY THE USER WITHOUT A CONSIDERABLE NUMBER OF CONDITIONALS TO GUARD AGAINST IT. IDEALLY, WE NEED TO FIGURE OUT HOW TO IMPLEMENT FOREIGN KEYS HERE, ASKING THE USER TO ENTER EITHER A KEY OR LOCATION NAME, CHECKING TO MAKE SURE THAT THE INPUT IS VALID, AND THEN ENTERING THE LOCATION NAME UNIQUE ID INTO THE LOCATION_ID FIELD OF THE PRODUCTS TABLE AS THE VALUE.
  ####

  # Public: .assign_product_location
  # A class method to move a product to a different location by assigning
  # a value to the location_id field in the 'products' table.
  #
  # Parameters:
  # existing_product_key - Integer, the primary key for the product record
  #                        being assigned a product location.
  # desired_location_id  - Integer, the value being set in location_id field
  #                        that references the primary key in the locations
  #                        table.
  # Returns:
  # None.
  # 
  # State Changes:
  # Integer, sets the field value for location_id and updates the products
  # table in the database.
  def self.assign_product_location(existing_product_key, desired_location_id)
    x = existing_product_key
    y = desired_location_id
    
    # consider using part or all of the code below for the cli menu conditionals
    # location_catcher = []
    # new_fetch = Product.fetch_product_record(x)
    # location_catcher = new_fetch[0]
    # puts location_catcher
    
    DATABASE.execute("UPDATE products SET location_id = #{y} 
                      WHERE id = #{x}")
  end

  # Public: .assign_product_category
  # A class method to assign a product to a category by assigning
  # a value to the category_id field in the 'products' table.
  #
  # Parameters:
  # existing_product_key - Integer, the primary key for the product record
  #                        being assigned a product category.
  # desired_category_id  - Integer, the value being set in category_id field
  #                        that references the primary key in the categories
  #                        table.
  # Returns:
  # None.
  # 
  # State Changes:
  # Integer, sets the field value for category_id and updates the products
  # table in the database.  
  def self.assign_product_category(existing_product_key, desired_category_id)
    x = existing_product_key
    y = desired_category_id
    
    DATABASE.execute("UPDATE products SET category_id = #{y} 
                      WHERE id = #{x}")
  end

  # Public: .update_product_quantity
  # A class method to set or update the product quantity field.
  #
  # Parameters:
  # existing_product_key - Integer, the primary key for the product record
  #                        being assigned a new quantity value.
  # desired_quantity     - Integer, the value being set in quantity field.
  #  
  # Returns:
  # None.
  # 
  # State Changes:
  # Integer, sets the field value for quantity and updates the products
  # table in the database.
  def self.update_product_quantity(existing_product_key, desired_quantity)
    x = existing_product_key
    y = desired_quantity
    
    DATABASE.execute("UPDATE products SET quantity = #{y} 
                      WHERE id = #{x}")
  end

  # Public: .where_products_in_category
  # A class method to fetch a list of products assigned to a category.
  #
  # Parameters:
  # category_id - Integer, the value for the category_id field.
  #
  # Returns:
  # A collection of products with the given category_id.
  # 
  # State Changes:
  # None.
  def self.where_products_in_category(category_id)
    results = DATABASE.execute("SELECT * FROM products WHERE category_id = 
                                 #{category_id}")
                                 
    #create an empty array to pass in each separate hash:
    # results_changed_to_objects = []
    # results_changed_to_objects = results

    # results.each do |database_hashes|
    # results_changed_to_objects << self.new(database_hashes)
    #
    # end
    # results_changed_to_objects
    results
  end

  # Public: .where_products_in_location
  # A class method to fetch a list of products assigned to a location.
  #
  # Parameters:
  # category_id - Integer, the value for the location_id field.
  #
  # Returns:
  # A collection of products with the given location_id.
  # 
  # State Changes:
  # None.  
  def self.where_products_in_location(location_id)
    results = DATABASE.execute("SELECT * FROM products WHERE location_id = 
                                 #{location_id}")
                                 
    #create an empty array to pass in each separate hash:
    # results_changed_to_objects = []
    # results_changed_to_objects = results

    # results.each do |database_hashes|
    # results_changed_to_objects << self.new(database_hashes)
    #
    # end
    # results_changed_to_objects
    
    results
  end
    
end