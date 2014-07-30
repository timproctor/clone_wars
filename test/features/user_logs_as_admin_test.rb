require_relative 'feature_test_helper'

class UserLogsAsAdmin < FeatureTest

  def test_user_fails_to_log_in_as_admin
    visit '/'
    assert_equal 200, page.status_code

    click_link('Login Here')
    assert_equal 200, page.status_code

    fill_in('username', with: 'ned')
    fill_in('password', with: 'stark')
    click_button('Login')

    assert page.has_content?("Login failed")
  end

  def test_user_successfully_logs_in_as_admin
    visit '/login'
    assert_equal 200, page.status_code

    fill_in('username', with: 'jon')
    fill_in('password', with: 'snow')
    click_button('Login')

    assert page.has_css?('.admin-header')
  end

end
