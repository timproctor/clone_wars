require 'rack/test'
require 'sinatra/base'
require './test/test_helper'


describe CloneWarsApp do
  include Rack::Test::Methods

  def app
    CloneWarsApp
  end

  it "goes where it's supposed to go" do
    get '/'
    assert last_response.ok?, "root"

    get '/catering'
    assert last_response.ok?, "catering"

    get '/location'
    assert last_response.ok?, "location"

    get '/menu_dinner'
    assert last_response.ok?, "menu_dinner"

    get '/restaurant'
    assert last_response.ok?, "restaurant"

    get '/specialties'
    assert last_response.ok?, "specialties"
  end
end
