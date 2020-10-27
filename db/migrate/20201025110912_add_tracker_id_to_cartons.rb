class AddTrackerIdToCartons < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_cartons, :easy_post_tracker_id, :string
    add_index :spree_cartons, :easy_post_tracker_id
  end
end
