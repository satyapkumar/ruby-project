require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  def setup
    @member = Member.new(username: "exampleUser", email: "member@example.com", last_name: "Hello", first_name: "World", gender: "Male", ago: 22, about_me: "I am a newbie", status: "Online", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @member.valid?
  end
  
  test "username should be present" do
    @member.username = " "
    assert_not @member.valid?
  end
  
  test "email should be present" do
    @member.email = " "
    assert_not @member.valid?
  end
  
  test "username should not be too long" do
    @member.username = "a" * 51
    assert_not @member.valid?
  end
  
  test "email should not be too long" do
    @member.email = "a" * 244 + "@example.com"
    assert_not @member.valid?
  end
  
  test "email validation should reject invalid address" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @member.email = invalid_address
      assert_not @member.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_member = @member.dup
    duplicate_member.email = @member.email.upcase
    @member.save
    assert_not duplicate_member.valid?
  end
  
  test "password should be present (nonblank)" do
    @member.password = @member.password_confirmation = " " * 6
    assert_not @member.valid?
  end
  
  test "password should have a minimum length" do
    @member.password = @member.password_confirmation = "a" * 5
    assert_not @member.valid?
  end
end
