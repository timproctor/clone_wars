require 'sqlite3'
require 'sequel'
require 'pry'

class Database
  def initialize(name)
    @db = Sequel.sqlite("#{name}.db")
    @db.create_table name.to_sym do
      primary_key :id
    end
  end
end


