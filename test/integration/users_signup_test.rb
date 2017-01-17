require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid data didnt result in a new user" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                     email: "user@invalid",
                                     password:              "foo",
                                     password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    #assert_select 'div.alert alert-danger'
  end

  test "valid information -> successful signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "john taylor",
                                     email: "user@invalid.com",
                                     password:              "superman07",
                                     password_confirmation: "superman07" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
