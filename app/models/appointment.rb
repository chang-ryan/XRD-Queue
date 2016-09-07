class Appointment < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :end_time,   presence: true
  validates :user_id,    presence: true

  validate :overlapping_appointments
  validate :times_arrow

  scope :overlapping, ->(appt) {
     where(%q{ (start_time, end_time) OVERLAPS (?,?) }, appt.start_time, appt.end_time)
    .where(%q{ id IS NOT NULL OR id != ? }, appt.id)
  }

  def find_overlapping
    self.class.overlapping(self)
  end

  def overlapping?
    self.class.overlapping(self).count > 0
  end

  def date=(date)
    Date.parse(date)
  end

  def start_hour=(hour)
  end

  def end_hour=(hour)
  end

  def start_hour
    self.start_time.try(:strftime, '%I:%M%p')
  end

  def end_hour
    self.end_time.try(:strftime, '%I:%M%p')
  end

  protected

    def overlapping_appointments
      if overlapping?
        errors.add(:overlapping, "This appointment overlaps with another")
      end
    end

    def times_arrow
      return if self.start_time.nil?
      return if self.end_time.nil?
      if self.start_time > self.end_time
        errors.add(:backwards, "You can't travel back in time")
      end
    end
end
