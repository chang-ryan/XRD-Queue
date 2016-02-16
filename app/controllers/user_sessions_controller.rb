class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.admin?
      log_in user
      redirect_to user
      flash[:success] = 'Admin logged in'
    elsif user
      # Log the user in and redirect to user's show page
      log_in user
      redirect_to user
      flash[:success] = 'You have successfully logged in'
    else
      flash.now[:danger] = 'Invalid credentials'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
