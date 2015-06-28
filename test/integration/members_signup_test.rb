require 'test_helper'

class MembersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Member.count' do
      post members_path, member: { username:  "",
                               email: "member@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'members/new'
  end
  
  test "valid signup information with account activation" do
    get signup_path
    assert_difference 'Member.count', 1 do
      post members_path, member: { username:  "Example User",
                                            email: "member@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    # assert_template 'members/show'
    # assert is_logged_in?
    assert_equal 1, ActionMailer::Base.deliveries.size
    member = assigns(:member)
    assert_not member.activated?
    # Try to log in before activation.
    log_in_as(member)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(member.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(member.activation_token, email: member.email)
    assert member.reload.activated?
    follow_redirect!
    assert_template 'members/show'
    assert is_logged_in?
  end
end
