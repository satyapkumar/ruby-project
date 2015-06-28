require 'test_helper'

class TimelineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @member = members(:amos)
    # This code is not idiomatically correct.
    @timeline = @member.timelines.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @timeline.valid?
  end

  test "member id should be present" do
    @timeline.member_id = nil
    assert_not @timeline.valid?
  end
  
  test "content should be present" do
    @timeline.content = "    "
    assert_not @timeline.valid?
  end
  
  test "content should be at most 140 characters" do
    @timeline.content = "a" * 141
    assert_not @timeline.valid?
  end
  
  test "order should be most recent first" do
    assert_equal timelines(:most_recent), Timeline.first
  end
end
