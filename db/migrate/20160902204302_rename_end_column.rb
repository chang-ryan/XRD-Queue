class RenameEndColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :appointments, :end
  end
end
