class AddApprovedToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :approved, :boolean, default: true
  end
end
