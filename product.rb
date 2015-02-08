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
  
  # def self.find(number)
  #   results = DATABASE.execute("SELECT * FROM products WHERE id =
  #                               #{number}")
  #   #results should only return one position in the array since we're
  #   #only requesting one variable:
  #
  #
  #
  #   return results[0]
  #   #self.new is a new class instance that will return an array containing
  #   #one record as a hash
  #   # record_details = results[0]
  #   # self.new("id" => "{record_details}")
  # end
end