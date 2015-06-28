class SessionsController < ApplicationController
  def new
  end
  
  def create
    member = Member.find_by(email: params[:session][:email].downcase)
    if member && member.authenticate(params[:session][:password])
      if member.activated?
        log_in member
        params[:session][:remember_me] == '1' ? remember(member) : forget(member)
        redirect_back_or member
      else
        message = "Account not activated"
        message += "Check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination' # Something is wrong
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
