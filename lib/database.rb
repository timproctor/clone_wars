require 'sqlite3'
require 'sequel'
require 'pry'

class Database

  attr_reader :db

  def initialize(name)
    # ask about storing db object as ivar or cosntant and how to use a test db, asshole
    @db = Sequel.sqlite("#{name}.db")
    create_tables
  end

  def create_tables
    db.create_table :menu do
      primary_key :id
      String      :name
      String      :ingredients
      String      :description
      String      :price
    end

    db.create_table :location do
      primary_key :id
      String      :address
      String      :email_address
      String      :phone_number
      String      :description
    end
  end

  def create_entry(table, data)
    db[table].insert(data)
  end

  def find(table, data)
    db[table].select.where(data).to_a
  end

  def update(table, data)
    binding.pry
    db[table].where(data).update.to_a
  end
  
end
