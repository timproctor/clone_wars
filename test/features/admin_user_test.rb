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

  def test_it_can_select_location_from_the_admin_dashboard
    skip
  end

  def test_that_an_admin_user_can_log_out
    login_as_admin
    click_button('Logout')
    visit '/login/admin_dashboard'
    assert_equal 401, page.status_code
  end
    
  def test_it_can_select_menu_on_admin_dashboard
    login_as_admin
    click_link('Menu')

    assert_equal 200, page.status_code
    assert_equal "http://www.example.com/login/admin_dashboard/menu", page.current_url
    assert page.has_css?('.edit-menu-header')
  end

  def test_an_admin_user_can_add_a_menu_item
    login_as_admin
    click_link('Menu')
    click_button('+')

    assert_equal "http://www.example.com/login/admin_dashboard/menu/add_menu_item", page.current_url

    fill_in('name', with: 'mushroom salad')
    fill_in('ingredients', with: 'mushrooms')
    fill_in('price', with: '100')
    fill_in('description', with: 'who the fuck is making a mushroom salad')
    click_button('add')

    assert page.has_content?("mushroom salad")

  end

    # it 'can see location editor page'
    # it 'can edit a location'
    # it 'can add a menu item'
    # it 'can delete a menu item'
    # it 'can update a menu item'

end
