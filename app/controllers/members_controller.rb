class MembersController < ApplicationController
  def new
  end
  
  def show
    @member = Member.find(params[:id])
  end
end
