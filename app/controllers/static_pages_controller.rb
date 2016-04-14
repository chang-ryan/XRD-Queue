class StaticPagesController < ApplicationController
  before_action :admin_user, only: :admin_panel

  def admin_panel
  end

  def help
  end

  def archive
  end

end
