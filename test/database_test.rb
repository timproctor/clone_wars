require './test/test_helper'
require './lib/database'

describe 'Database' do

  def teardown
    File.delete(File.expand_path('test_database.db'))
  end

  it "creates a database" do
    refute File.exists?('test_database.db'), 'Crap, there is already a DB!'
    db = Database.new('test_database')
    assert File.exists?('test_database.db'), 'Where is my database?'
  end

  it "creates all the tables" do
    database = Database.new('test_database')

    menu     = database.db[:menu]
    location = database.db[:location]

    assert menu
    assert location
    assert_includes menu.columns, :ingredients
    assert_includes location.columns, :description
  end

  it "adds an entry to the database" do
    database = Database.new('test_database')
    menu = database.db[:menu]

    assert_equal 0, menu.count

    database.create_entry(:menu, name: "Gyro", ingredients: "goodshit")
    entry = menu.select.where(name: 'Gyro').to_a.first

    assert_equal 'Gyro', entry[:name]
  end

  it "finds some data from the database" do
    database = Database.new('test_database')
    database.create_entry(:menu,
                          name: "mushroom salad",
                          ingredients: "mushrooms?",
                          description: "this is a salad asshole",
                          price: "100")

    menu = database.db[:menu]

    data = {
      name: "mushroom salad"
    }

    search_data = database.find(:menu, data)

    assert_equal "mushroom salad", search_data.first[:name]
  end

  # it "gives me a reach around"
  # it "updates data from the database" do
  #   #assert something exists in the database
  #   database = Database.new('test_database')
  #   database.create_entry(:menu,
  #                         name: "mushroom salad",
  #                         ingredients: "mushrooms?",
  #                         description: "this is a salad asshole",
  #                         price: "100")
  #
  #   # menu = database.db[:menu]
  #   entry = database.find(:menu, name: 'mushroom salad')
  #
  #   assert_equal 'mushroom salad', entry.first[:name]
  #
  #   #update the existing database entry
  #   updated_entry = database.update(:menu, name: 'gravy tacos', description: 'hi')
  #
  #   assert_equal 'gravy tacos', updated_entry.first[:name]
  #   #verify that data is updated
  #
  # end

end
