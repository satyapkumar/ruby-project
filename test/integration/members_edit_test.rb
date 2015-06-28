require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @member = members(:amos)
  end

  test "unsuccessful edit" do
    log_in_as(@member)
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), member: { username:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'members/edit'
  end
  
  test "successful edit with friendly forwarding" do
    get edit_member_path(@member)
    log_in_as(@member)
    assert_redirected_to edit_member_path(@member)
    # assert_template 'members/edit'
    username  = "Foo Bar"
    email = "foo@bar.com"
    patch member_path(@member), member: { username:  username,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @member
    @member.reload
    assert_equal username,  @member.username
    assert_equal email, @member.email
  end
end
