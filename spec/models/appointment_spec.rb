require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it "has a valid factory" do
    Factory.create(:appointment).should be_valid
  end

  it 'is invalid without start time'
  it 'is invalid without end time'
  it 'is invalid without a corresponding user id'
  it 'is invalid when overlapping'
end
