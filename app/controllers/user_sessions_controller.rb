class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # if user.activated?
        # Log the user in and redirect to user's show page
        log_in user
        if user.admin?
          flash[:success] = 'Admin logged in.'
        else
          flash[:success] = 'You have successfully logged in'
        end

        if session[:forwarding_url]
          redirect_to session[:forwarding_url]
        else
          redirect_to user
        end
      # else
      #   message  = "Account not activated. "
      #   message += "Check your email for activation link."
      #   flash[:warning] = message
      #   redirect_to root_url
      # end
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
