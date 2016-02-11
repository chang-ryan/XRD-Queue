class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @entries = @user.entries
    @entry = current_user.entries.build if logged_in?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :department)
    end
end
