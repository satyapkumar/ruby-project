class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @timeline = current_member.timelines.build
      @feed_items = current_member.feed.paginate(page: params[:page])
    end
  end

  def about
  end

  def help
  end
  
  def contact
  end
end
