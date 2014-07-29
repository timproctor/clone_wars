require_relative 'feature_test_helper'

class UserLogsAsAdmin < FeatureTest
  def test_user_can_log_in_as_admin
    visit '/'
    assert_equal 200, page.status_code

    click_link('Login bitch')
    assert_equal 200, page.status_code

    fill_in('username', with: 'ned')
    fill_in('password', with: 'stark')
    click_button('Login')

    assert page.has_content?("Login failed")

    # verify that we dont move on to the login page
    # verify that with incorrect login takes you to unsuccessful login page
    assert 
  end
end