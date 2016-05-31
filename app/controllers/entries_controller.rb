class EntriesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :destroy, :toggle_scanned]
  before_action :admin_user,     only: :download_and_delete

  include EntriesHelper

  def index
    # sends instance variables @scanned_entries and @unscanned_entries to views
    split_entries
    @entry = current_user.entries.build if logged_in?

    # sends instance variable to js for precise ajax response
    @render_switch = "scanned" if !params[:scanned_search].nil? or !params[:scanned_page].nil?
    @render_switch = "unscanned" if !params[:unscanned_search].nil? or !params[:unscanned_page].nil?

    # MUST be at the end of method for proper functioning
    # if @render_switch is below respond_to, it will break
    respond_to do |format|
      format.html
      format.js
      format.csv { render text: Entry.all.to_csv, content_type: 'text/plain' }
      # format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Sample added to the queue!"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "Please fill out all the required fields."
      redirect_to request.referrer
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    @entry.update(entry_params)
    flash[:success] = "Entry successfully updated."
    redirect_to entry_path(@entry)
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def toggle_scanned
    @entry = Entry.find(params[:id])
    @entry.toggle!(:scanned)
    flash[:success] = "Sample scanned and archived" if @entry.scanned
    redirect_to request.referrer || root_url
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    flash[:success] = "Sample deleted"
    redirect_to request.referrer || root_url
  end

  def scan
    @entry = Entry.find(params[:id])
    @entry.toggle!(:scanned)
    flash[:success] = "Sample scanned and archived"
    redirect_to request.referrer || root_url
  end

  def download
    time = Time.now.strftime "%Y-%m-%d %H:%M"
    filename = "XRD Export #{time}.csv"
    send_data Entry.all.to_csv, filename: filename
  end

  def download_and_delete
    download
    Entry.where(:scanned => true).delete_all
  end

  def usage_stats
    @total_entries_submitted = Entry.all.count

    # @charge_numbers = Entry.uniq.pluck(:charge).map! { |x| x.strip[0,10] }.uniq.sort

    @charge_numbers = Entry.uniq.pluck(:charge).map { |x| x.strip }.sort

    @usage = {}

    @charge_numbers.each do |num|
      @usage[num] = {}
      # @usage[num]["percent"] = (Entry.where('charge ~* :pattern', :pattern => num).count / @total_entries_submitted.to_f).round(3)
      # @usage[num]["total"]   = Entry.where('charge ~* :pattern', :pattern => num).count
      @usage[num]["percent"] = ((Entry.where(:charge => num).count / @total_entries_submitted.to_f) * 100).round(2)
      @usage[num]["total"]   = Entry.where(:charge => num).count
    end
  end


  private

    def entry_params
      params.require(:entry).permit(:sample, :charge, :need_by, :file_format, :scan_type, :description, :instructions, :conditions)
    end

    def correct_user
      unless current_user.admin?
        @entry = current_user.entries.find_by(id: params[:id])
        if @entry.nil?
          flash[:danger] = "This sample does not belong to you."
          redirect_to root_url
        end
      end
    end

end
