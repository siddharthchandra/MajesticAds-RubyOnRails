require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user=users(:rishabh)
	end

	test "unsuccessful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path, params: {user: {name: "", email: "user@invalid", password: "a", password_confirmation: "b"}}
		assert_template 'users/edit'
	end

	test "successful edit" do
		log_in_as(@user)
		name="Guy"
		email="guy@email.com"
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path, params: {user: {name: name, email: email, password: "", password_confirmation: ""}}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end

	test "successful edit with friendly forwarding" do
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		name="Guy"
		email="guy@email.com"
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path, params: {user: {name: name, email: email, password: "", password_confirmation: ""}}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end
end
