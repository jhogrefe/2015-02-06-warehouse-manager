class Location 
 attr_reader :id
 attr_accessor :location_name
 
 def initialize(options)
   @location_name = "#{options}"
   @id = options["id"]
 end
 
 #Method 'create' adds a new table row to the locations table
 
 def create
   DATABASE.execute("INSERT INTO locations (location_name) 
                     VALUES ('#{@location_name}')")
   @id = DATABASE.last_insert_row_id
 end
end