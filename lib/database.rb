class Database
  # creates a sqlite database in memory
  DB = Sequel.sqlite

  # creates a table with the name location
  DB.create_table :location do
    primary_key :id
    String :name
    String :address
    String :phone_number
    String :email_address
    String :description
  end
end
