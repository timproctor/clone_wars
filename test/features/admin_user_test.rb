require_relative 'feature_test_helper'

class AdminUserTest < FeatureTest

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

  def login_as_admin
    visit '/login'
    fill_in('username', with: 'jon')
    fill_in('password', with: 'snow')
    click_button('Login')
  end

  def test_admin_can_visit_the_admin_console
    login_as_admin

    assert_equal 200, page.status_code
    assert page.has_css?(".admin-header")
  end

  def test_it_can_select_location_from_the_admin_dashboard
    
  end
    # it 'can select menu on admin dashboard'
    # it 'can see location editor page'
    # it 'can edit a location'
    # it 'can see menu editor page'
    # it 'can add a menu item'
    # it 'can delete a menu item'
    # it 'can update a menu item'

end
