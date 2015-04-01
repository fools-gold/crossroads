class AddLikeableToLike < ActiveRecord::Migration
  def change
    rename_column :likes, :status_id, :likeable_id
    add_column :likes, :likeable_type, :string, null: false, default: 'Status'
    change_column_default(:likes, :likeable_type, nil)
  end
end
