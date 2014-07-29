require './test/test_helper'
require './lib/database'

describe 'Database' do
  it "creates a database" do
    refute File.exists?('awesome_database.db'), 'Crap, there is already a DB!'
    db = Database.new('awesome_database')
    assert File.exists?('awesome_database.db'), 'Where is my database?'
    assert db.has_key?(:awesome_database)
  end

  it "updates a database" do
    skip
    # check the data in the database
    db = Sequel.sqlite('testing_db.db')

    unless db.table_exists?(:test_table)
      db.create_table :test_table do
        primary_key :id
        String :name
        String :age
      end
    end

    test_table = db[:test_table]
    test_table.delete

    test_table.insert(name: "You know nothing Jon Snow", age: "500")

    a = test_table.select.to_a
    assert_equal a[0][:age], "500"

    # call the update method and pass in new data
    class Person
      attr_reader :name, :age

      def initialize(name, age)
        @name = name
        @age = age
      end

      def to_h
        {
          name: name,
          age: age
        }
      end
    end

    person = Person.new("Charlie", "1000")
    table = :test_table

    Database.update(table, person.to_h)
    a = test_table.select.to_a

    assert_equal a[0][:age], "1000"
    # check that the data in the database is correct
  end
end
