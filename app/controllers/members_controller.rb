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
      log_in @member
      # Handle a successful save.
      flash[:success] = "Welcome to Online Dating!"
      redirect_to @member
    else
      render 'new'
    end
  end
  
  def edit
    @member = Member.find(params[:id])
  end
  
  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end
  
  private

    def member_params
      params.require(:member).permit(:username, :email, :password,
                                   :password_confirmation)
    end
end
