class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :destroy]
  before_action :correct_user,   only: [:edit, :destroy]
  before_action :admin_user,     only: :toggle_scanned

  include EntriesHelper

  def index
    @entries = Entry.all
    split_entries(@entries)
    @entry = current_user.entries.build if logged_in?
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Sample added to the queue!"
      redirect_to request.referrer || root_url
    else
      render request.referrer
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

  def edit
    @entry = Entry.find(params[:id])
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

    def admin_user
      unless current_user.admin?
        flash[:danger] = "Please use the admin account to perform this action."
        redirect_to request.referrer || root_url
      end
    end
end
