require 'sqlite3'
require 'sequel'

Sequel::Model.plugin(:schema)

if ENV['RUBY_ENV'] == 'test'
  DB = Sequel.sqlite("clone_wars_testing.db")
else


  DB = Sequel.sqlite("production.db")
end

# DB = Sequel.sqlite("production.db")

unless DB.table_exists?(:menu_items)
  DB.create_table :menu_items do
    primary_key :id
    String      :name
    String      :ingredients
    String      :price
  end
end

unless DB.table_exists?(:location)
  DB.create_table :location do
    primary_key :id
    String      :address
    String      :email_address
    String      :phone_number
    String      :description
  end
end
