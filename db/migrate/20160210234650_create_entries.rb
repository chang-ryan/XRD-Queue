class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string     :sample
      t.string     :charge
      t.string     :need_by, default: "In Line"
      t.string     :file_format
      t.string     :scan_type
      t.text       :description
      t.text       :conditions
      t.text       :instructions
      t.boolean    :scanned, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :entries, [:user_id, :created_at]
  end
end
