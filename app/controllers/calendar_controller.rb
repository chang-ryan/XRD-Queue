class CalendarController < ApplicationController
  before_action :logged_in_user, only: :show

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_by_date = Appointment.all.order('start_time ASC').group_by { |item| item.send(:start_time).strftime('%Y-%m-%d')}
  end

  def show
    @date = Date.parse(params[:id])
    @appointments_today = Appointment.where("start_time::date = ?", params[:id]).order(start_time: :asc)
    @appointment = current_user.appointments.build if logged_in?
  end
end
