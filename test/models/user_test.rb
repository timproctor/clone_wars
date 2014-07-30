require_relative 'model_test_helper'
require_relative '../../lib/app/models/user'

class UserTest < Minitest::Test

  def admin
    {
      username: 'jon',
      password: 'snow'
    }
  end

  def non_admin
    {
      username: 'not',
      password: 'correct'
    }
  end

  def test_it_checks_if_a_user_has_admin_credentials
    user = User.new(admin[:username], admin[:password])
    assert user.admin?('jon', 'snow')
  end

  def test_it_knows_when_username_or_password_is_incorect
    user = User.new(non_admin[:username], non_admin[:password])
    refute user.admin?('not', 'correct')
  end

end
