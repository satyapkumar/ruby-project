require 'test_helper'

class MembersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @member = members(:amos)
  end

  test "unsuccessful edit" do
    get edit_member_path(@member)
    assert_template 'members/edit'
    patch member_path(@member), member: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'members/edit'
  end
end
