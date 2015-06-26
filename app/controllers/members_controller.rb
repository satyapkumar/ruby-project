class MembersController < ApplicationController
  def new
    @member = Member.new
  end
  
  def show
    @member = Member.find(params[:id])
  end
  
  def create
    @member = Member.new(member_params)
    if @member.save
      # Handle a successful save.
      flash[:success] = "Welcome to Online Dating!"
      redirect_to @member
    else
      render 'new'
    end
  end
  
  private

    def member_params
      params.require(:member).permit(:username, :email, :password,
                                   :password_confirmation)
    end
end
