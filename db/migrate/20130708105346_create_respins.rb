class CreateRespins < ActiveRecord::Migration
  def up
 	create_table :respins do |t|
     t.integer :respinner_id
     t.integer :spin_id

     t.timestamps
   end
 end

 def down
 	drop_table :respins
 end
end
