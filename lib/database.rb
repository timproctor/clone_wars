require 'sequel'
require 'sqlite3'

class Database
  def self.database
    @db = Sequel.sqlite('cafecolore.db')

    unless @db.table_exists?(:location)
      @db.create_table :location do
        primary_key :id
        String :name
        String :address
        String :phone_number
        String :email_address
        String :description
      end
    end
    @db
  end

  def self.update(table, data)
    table = database[table]
    location = Location.new(data)
    table.update(location.to_h)
  end
end
