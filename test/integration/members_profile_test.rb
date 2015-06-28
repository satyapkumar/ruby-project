require 'test_helper'

class MembersProfileTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  include ApplicationHelper
  
  def setup
    @member = members(:amos)
  end
  
  test "profile display" do
    get member_path(@member)
    assert_template 'members/show'
    assert_select 'title', full_title(@member.username)
    assert_select 'h1', text: @member.username
    # assert_select 'h1>img.gravatar'
    assert_match @member.timelines.count.to_s, response.body
    assert_select 'div.pagination'
    @member.timelines.paginate(page: 1).each do |timeline|
      assert_match timeline.content, response.body
    end
  end
end
