class AddIndexesToRespins < ActiveRecord::Migration
  def change
  	add_index :respins, :respinner_id
    add_index :respins, :spin_id
    add_index :respins, [:respinner_id, :spin_id], unique: true
  end
end
