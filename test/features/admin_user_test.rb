require_relative 'feature_test_helper'

class AdminUserTest < FeatureTest

  def test_admin_can_visit_the_admin_console
    visit '/login/admin_dashboard'
    assert_equal 200, page.status_code
  end
    # it 'can select location on admin dashboard'
    # it 'can select menu on admin dashboard'
    # it 'can see location editor page'
    # it 'can edit a location'
    # it 'can see menu editor page'
    # it 'can add a menu item'
    # it 'can delete a menu item'
    # it 'can update a menu item'

end
