require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  
  def setup
    @member = members(:amos)
    @other_member = members(:archer)
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @member
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @member, member: { username: @member.username, email: @member.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong member" do
    log_in_as(@other_member)
    get :edit, id: @member
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong member" do
    log_in_as(@other_member)
    patch :update, id: @member, member: { username: @member.username, email: @member.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Member.count' do
      delete :destroy, id: @member
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_member)
    assert_no_difference 'Member.count' do
      delete :destroy, id: @member
    end
    assert_redirected_to root_url
  end

end
