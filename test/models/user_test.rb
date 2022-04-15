require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", 
      password:"foobar", password_confirmation:"foobar")
  end

  test "should be valid" do
    assert @user.valid? 
  end

  test "name should be present" do 
    @user.name =""
    assert_not @user.valid? 
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid? 
  end

  test "username should not be too long" do 
    @user.name = 'a'* 51 #change from magic number
    assert_not @user.valid? 
  end

  test "email should not be too long" do 
    @user.email = "a" * 244 + "@example.com" #change from magic number
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do 

    valid_addresses = %w[user@example.com USER@foo.com 
      A_User@foo.bar.org first.last@foo.jp alice+bob@foo.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do

    invalid_addresses = %w[user@example,com User_at_foo.com 
      foo@foo_baz.com foo@bar+bar.com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do 
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end

