class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :admin_user,     only: :toggle_scanned

  def index
    @entries = Entry.all
    @entry = current_user.entries.build if logged_in?
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Sample added to the queue!"
      redirect_to request.referrer || root_url
    else
      render 'create'
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def destroy
    @entry.destroy
    flash[:success] = "Sample deleted"
    redirect_to request.referrer || root_url
  end

  def toggle_scanned
    @entry = Entry.find(params[:id])
    @entry.scanned = true
  end

  private

    def entry_params
      params.require(:entry).permit(:sample, :charge, :need_by, :file_format, :scan_type)
    end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end
