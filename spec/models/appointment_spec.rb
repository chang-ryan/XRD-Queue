require 'rails_helper'

RSpec.describe Appointment, type: :model do
  before do
    @ryan = User.create(name: 'Ryan', email: 'rchang@hrl.com', password: 'asdf', password_confirmation: 'asdf')

    # define start and end points
    @start_time = Time.now
    @end_time   = @start_time + 2000

    # commit to database so that one appointment exists to be overlapped with
    @appt = @ryan.appointments.create(start_time: @start_time, end_time: @end_time)
  end

  it 'is invalid without start time' do
    expect(Appointment.new(end_time: Time.now)).to_not be_valid
  end

  it 'is invalid without end time' do
    expect(Appointment.new(start_time: Time.now)).to_not be_valid
  end

  it 'is invalid without a corresponding user id' do
    expect(Appointment.new(start_time: Time.now, end_time: Time.now+2000)).to_not be_valid
  end

  context 'overlapping points' do
    it 'is invalid when it ends inside another' do
      expect(Appointment.new(start_time: @start_time-2000, end_time: @end_time-1999)).to_not be_valid
    end
    it 'is invalid when it starts inside another' do
      expect(Appointment.new(start_time: @start_time+1999, end_time: @end_time+2000)).to_not be_valid
    end
    it 'is invalid when it is entirely in another' do
      expect(Appointment.new(start_time: @start_time+1, end_time: @end_time-1)).to_not be_valid
    end
    it 'is invalid when it is entirely around another' do
      expect(Appointment.new(start_time: @start_time-1, end_time: @end_time+1)).to_not be_valid
    end
  end

  it 'is invalid when start time is equal to end time' do
    expect(Appointment.new(start_time: @end_time+1, end_time: @end_time+1)).to_not be_valid
  end

  it 'is invalid when going back in time' do
    expect(Appointment.new(start_time: Time.parse('01:00'), end_time: Time.parse('00:00'))).to_not be_valid
  end

  it 'is valid with all correct fields' do
    expect(@ryan.appointments.new(start_time: @end_time+1, end_time: @end_time+2000)).to be_valid
  end
end
