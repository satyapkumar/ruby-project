class MembersController < ApplicationController
  before_action :logged_in_member, only: [:index, :edit, :update, :destroy]
  before_action :correct_member, only: [:edit, :update]
  before_action :admin_member, only: :destroy
  
  def new
    @member = Member.new
  end
  
  def index
    @members = Member.paginate(page: params[:page])
  end
  
  def show
    @member = Member.find(params[:id])
    @timelines = @member.timelines.paginate(page: params[:page])
  end
  
  def create
    @member = Member.new(member_params)
    if @member.save
      @member.send_activation_email
      # Handle a successful save.
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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
      flash[:success] = "Profile updated"
      redirect_to @member
    else
      render 'edit'
    end
  end
  
  def destroy
    Member.find(params[:id]).destroy
    flash[:success] = "Member deleted"
    redirect_to members_url
  end
  
  private

    def member_params
      params.require(:member).permit(:username, :email, :password,
                                   :password_confirmation)
    end
    # Before filters
    # Confirms a logged-in member
    def logged_in_member
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
    
    # Confirms the correct member.
    def correct_member
      @member = Member.find(params[:id])
      redirect_to(root_url) unless current_member?(@member)
    end
    
    # Confirms an admin member
    def admin_member
      redirect_to(root_url) unless current_member.admin?
    end
end
