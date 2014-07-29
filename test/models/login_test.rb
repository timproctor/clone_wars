require_relative '../test_helper'
require_relative '../../lib/login'

class LoginTest < Minitest::Test

  def login_data(username, password)
    {
      username: username,
      password: password
    }
  end

  def test_it_authenticates_an_admin_user
    login_data = login_data("jon", "snow")
    login = Login.new(login_data[:username], login_data[:password])
    assert login.authenticated?
  end

  def test_it_rejects_non_admin_user
    login_data = login_data("not", "snow")
    login = Login.new(login_data[:username], login_data[:password])
    refute login.authenticated?
  end

end
