class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include UserSessionsHelper

  before_filter :get_notice

  def set_notice
    if Notice.first
      Notice.first.update(body: params[:notice_message])
    else
      Notice.create(body: params[:notice_message])
    end

    redirect_to request.referrer || root_url
  end

  def get_notice
    @notice = Notice.first.body if Notice.first
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url
      end
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = "Please use the admin account to perform this action."
        redirect_to request.referrer || root_url
      end
    end

end
