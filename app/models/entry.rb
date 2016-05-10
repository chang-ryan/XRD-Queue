# app/models/entry.rb
class Entry < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :sample, :charge, :need_by, :scan_type, presence: true

  def self.search(search)
    if search
      joins(:user).where('users.name ILIKE :search OR sample ILIKE :search    OR
      need_by ILIKE :search    OR scan_type ILIKE :search OR
      charge ILIKE :search',
      search: "%#{search}%")
    else
      all
    end
  end

  def self.to_csv(options = {})
    joins(:user)
    column_names << "user_name"
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |entry|
        data = entry.attributes.values_at(*column_names)
        data[-1] = entry.user.name
        csv << data
      end
    end
  end
end
