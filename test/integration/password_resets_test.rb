require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    ActionMailer::Base.deliveries.clear
    @member = members(:amos)
  end

  # test "expired token" do
  #   get new_password_reset_path
  #   post password_resets_path, password_reset: { email: @member.email }

  #   @member = assigns(:member)
  #   @member.update_attribute(:reset_send_at, 3.hours.ago)
  #   patch password_reset_path(@member.reset_token),
  #         email: @member.email,
  #         member: { password:              "foobar",
  #                 password_confirmation: "foobar" }
  #   assert_response :redirect
  #   follow_redirect!
  #   assert_match /FILL_IN/i, response.body
  # end
  
  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Valid email
    post password_resets_path, password_reset: { email: @member.email }
    assert_not_equal @member.reset_digest, @member.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Password reset form
    member = assigns(:member)
    # Wrong email
    get edit_password_reset_path(member.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive member
    member.toggle!(:activated)
    get edit_password_reset_path(member.reset_token, email: member.email)
    assert_redirected_to root_url
    member.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email: member.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(member.reset_token, email: member.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", member.email
    # Invalid password & confirmation
    patch password_reset_path(member.reset_token),
          email: member.email,
          member: { password:              "foobaz",
                  password_confirmation: "barquux" }
    assert_select 'div#error_explanation'
    # Empty password
    patch password_reset_path(member.reset_token),
          email: member.email,
          member: { password:              "",
                  password_confirmation: "" }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    # Valid password & confirmation
    patch password_reset_path(member.reset_token),
          email: member.email,
          member: { password:              "foobaz",
                  password_confirmation: "foobaz" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to member
  end
end
