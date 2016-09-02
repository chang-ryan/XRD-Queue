class RenameAppointmentsColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :appointments, :start, :start_time
  end
end
