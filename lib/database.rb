require 'sqlite3'
require 'sequel'

Sequel::Model.plugin(:schema)

DB = Sequel.sqlite("production.db")

unless DB.table_exists?(:menu_items)
  DB.create_table :menu_items do
    primary_key :id
    String      :name
    String      :ingredients
    String      :description
    String      :price
  end
end

unless DB.table_exists?(:locations)
  DB.create_table :locations do
    primary_key :id
    String      :address
    String      :email_address
    String      :phone_number
    String      :description
  end
end
