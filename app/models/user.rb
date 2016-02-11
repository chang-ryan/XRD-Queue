class User < ActiveRecord::Base
  has_many :entries

  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\w+@hrl\.com/i
  validates :name,  presence: true
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
end
