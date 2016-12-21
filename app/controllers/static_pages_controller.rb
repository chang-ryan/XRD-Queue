class StaticPagesController < ApplicationController
  before_action :admin_user, only: :admin_panel

  include StaticPagesHelper

  def admin_panel
  end

  def admin_panel_controls
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

  # def usage_stats
  #   @total_entries_submitted = Entry.all.count
  #
  #   @charge_numbers = Entry.uniq.pluck(:charge).map! { |x| x.strip[0,10] }.uniq.sort
  #   @usage = {}
  #
  #   @charge_numbers.each do |num|
  #     @usage[num] = {}
  #     @usage[num]["percent"] = (Entry.where('charge ~* :pattern', :pattern => num).count / @total_entries_submitted.to_f).round(3)
  #     @usage[num]["total"]   = Entry.where('charge ~* :pattern', :pattern => num).count
  #   end
  # end

end
