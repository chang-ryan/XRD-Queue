class Notice < ApplicationRecord
  before_create :only_one_row

  private

    def only_one_row
      errors.add(:base, "You can create only one row of this table") if Notice.count > 0
      raise "You can create only one row of this table"
    end
end
