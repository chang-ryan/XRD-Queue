class Appointment < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :end_time,   presence: true
  validates :user_id,    presence: true

  validate :overlapping_appointments

  scope :overlapping, ->(appt) {
     where(%q{ (start_time, end_time) OVERLAPS (?,?) }, appt.start_time, appt.end_time)
    .where(%q{ id != ? }, appt.id)
  }

  def find_overlapping
    self.class.overlapping(self)
  end

  def overlapping?
    self.class.overlapping(self).count > 0
  end

  protected

    def overlapping_appointments
      if overlapping?
        errors[:overlapping] = "This appointment overlaps with another"
      end
    end
end
