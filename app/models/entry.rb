class Entry < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :sample, :charge, :need_by, :file_format, :scan_type, presence: true
end
