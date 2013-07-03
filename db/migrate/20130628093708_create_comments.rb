class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :body
      t.integer :spin_id
      t.integer :user_id

      t.timestamps
    end
  end
  def down
    drop_table :comments
  end
end
