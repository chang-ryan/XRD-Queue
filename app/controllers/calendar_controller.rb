class CalendarController < ApplicationController
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_by_date = Appointment.all.group_by { |item| item.send(:start_time).strftime('%Y-%m-%d')}
  end

  def show
    @date = Date.parse(params[:id])
    @appointment = current_user.appointments.build if logged_in?
  end
end
