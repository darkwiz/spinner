class AddTypemultimediaToSpins < ActiveRecord::Migration
  def change
    add_column :spins, :type, :string
  end
end
