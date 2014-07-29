require_relative "../test_helper"
require 'capybara'
require 'sinatra'
require 'haml'
require_relative '../../lib/app.rb'

Capybara.app = CloneWarsApp

# Feature test classes will inherit from this shit
class FeatureTest < Minitest::Test
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver # Webkit?
  end
end