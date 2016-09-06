class AppointmentsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @appointments = @user.appointments
  end

  def create
    start_time = Time.parse("#{appointment_params[:date]} at #{appointment_params[:start_hour]}")
    end_time   = Time.parse("#{appointment_params[:date]} at #{appointment_params[:end_hour]}")
    notes      = appointment_params[:notes]
    @appointment = current_user.appointments.build(start_time: start_time, end_time: end_time, notes: notes)
    if @appointment.save
      flash[:success] = "Appointment successfully scheduled!"
      redirect_to request.referrer
    else
      if @appointment.errors
        flash[:alert] = @appointment.errors.full_messages.join(', ')
      else
        flash[:danger] = "Please fill out all the required fields."
      end
      redirect_to request.referrer
    end
  end

  private

    def appointment_params
      params.require(:appointment).permit(:start_hour, :end_hour, :notes, :date)
    end
end
