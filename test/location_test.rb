require './test/test_helper'
require './lib/location'

class LocationTest < Minitest::Test
  def location_data
    {
      name: "Jon Snow",
      address: "1510 Blake St. Denver, CO 90120",
      phone_number: "867-5309",
      email_address: "example@example.com",
      description: "Tim likes poop."
    }
  end

  def test_it_has_the_correct_attributes
    location = Location.new(location_data)
    assert_equal "Jon Snow", location.name
  end
end