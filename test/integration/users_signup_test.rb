require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count' do
			assert_select 'form[action="/signup"]'
			post signup_path, params: {user: {name: "", email: "user@invalid", password: "a", password_confirmation: "b"}}
		end
		assert_template 'users/new'
	end

	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			assert_select 'form[action="/signup"]'
			post signup_path, params: {user: {name: "Example User", email: "user@example.com", 
												password: "foobar", password_confirmation: "foobar"}}
		end
		follow_redirect!
		assert_template 'users/show'
		assert is_logged_in?
		assert_not flash.empty?
	end
end
