class CreateSpins < ActiveRecord::Migration
  def change
    create_table :spins do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :spins, [:user_id, :created_at]
  end
end
