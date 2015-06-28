require 'test_helper'

class TimelinesInterfaceTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @member = members(:amos)
  end

  test "timeline post interface" do
    log_in_as(@member)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Timeline.count' do
      post timelines_path, timeline: { content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This timeline really ties the room together"
    assert_difference 'Timeline.count', 1 do
      post timelines_path, timeline: { content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_timeline = @member.timelines.paginate(page: 1).first
    assert_difference 'Timeline.count', -1 do
      delete timeline_path(first_timeline)
    end
    # Visit a different member.
    get member_path(members(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
