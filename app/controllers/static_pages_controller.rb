class StaticPagesController < ApplicationController
  before_action :admin_user, only: :admin_panel

  include StaticPagesHelper

  def admin_panel
  end

  def db_manage
  end

  def help
  end

  def about
  end

  def archive
    @scanned_entries = Entry.where(:scanned => true)
                                 .order(updated_at: :desc)
                                 .search(params[:scanned_search])
                                 .paginate(:per_page => 20, :page => params[:scanned_page])
  end

end
