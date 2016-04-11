class UsersController < ApplicationController
  before_action :logged_in_user, only: :show

include EntriesHelper

  def show
    @user = User.find(params[:id])
    @entries = @user.entries
    split_entries(@entries)
    @entry = current_user.entries.build if logged_in?
  end

  def new
    @user = User.new
    # flash[:danger] = "Registrations are currently closed."
    # redirect_to root_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      # flash[:success] = "Account successfully created! Please check your email to activate."
      flash[:success] = "Account successfully created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
