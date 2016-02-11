class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      # Log the user in and redirect to user's show page
      log_in user
      redirect_to user
      flash[:success] = 'You have successfully logged in'
    else
      flash.now[:danger] = 'Invalid email, please register your email'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
