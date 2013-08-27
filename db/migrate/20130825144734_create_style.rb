class CreateStyle < ActiveRecord::Migration
  def up
  	create_table :styles do |t|
     t.integer :user_id
     t.string :well_color
     t.string :background_color
     t.boolean :nav_inverse, default: true
     t.string :background_image

     t.timestamps
  end
  end

  def down
  	drop_table :styles
  end
end
