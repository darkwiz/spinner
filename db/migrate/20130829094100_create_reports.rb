class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
      t.integer :user_id
      t.string :content
      t.string :type

      t.integer :reported_user_id
      t.integer :reported_spin_id
      t.integer :reported_comment_id

      t.timestamps
    end
  end
  def down
  	drop_table :reports
  end
end
