require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path params: {user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'

  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do 
      post users_path params: {user: {name: "Rails Tutorial",
                                      email: "example@railstutorial.org",
                                      password: "foobar66",
                                      password_confirmation:"foobar66"}}      
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
