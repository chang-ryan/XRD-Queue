# app/models/entry.rb
class Entry < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :sample, :charge, :need_by, :file_format, :scan_type, presence: true

  def self.search(search)
    if search
      joins(:user).where('users.name LIKE :search OR entries.created_at LIKE :search OR sample LIKE :search OR need_by LIKE :search OR scan_type LIKE :search OR charge LIKE :search', search: "%#{search}%")
    else
      all
    end
  end
end
