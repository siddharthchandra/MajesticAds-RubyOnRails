require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Majestic Ads"
    assert_equal full_title("Help"), "Help | Majestic Ads"
  end
end