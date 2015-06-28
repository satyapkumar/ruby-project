class TimelinesController < ApplicationController
    before_action :logged_in_member, only: [:create, :destroy]
    before_action :correct_member, only: :destroy
    
    def create
        @timeline = current_member.timelines.build(timeline_params)
        if @timeline.save
            flash[:success] = "Timeline created!"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end
    
    def destroy
        @timeline.destroy
        flash[:success] = "Timeline post deleted"
        redirect_to request.referer || root_url
    end
    
    private
    def timeline_params
        params.require(:timeline).permit(:content, :picture)
    end
    
    def correct_member
        @timeline = current_member.timelines.find_by(id: params[:id])
        redirect_to root_url if @timeline.nil?
    end
end
