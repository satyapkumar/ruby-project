require 'test_helper'

class MembersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Member.count' do
      post members_path, member: { username:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'members/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'Member.count', 1 do
      post_via_redirect members_path, member: { username:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'members/show'
  end
end
