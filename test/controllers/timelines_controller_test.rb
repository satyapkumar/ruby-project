require 'test_helper'

class TimelinesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @timeline = timelines(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Timeline.count' do
      post :create, timeline: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Timeline.count' do
      delete :destroy, id: @timeline
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy for wrong timeline post" do
    log_in_as(members(:amos))
    timeline = timelines(:ants)
    assert_no_difference 'Timeline.count' do
      delete :destroy, id: timeline
    end
    assert_redirected_to root_url
  end
end
