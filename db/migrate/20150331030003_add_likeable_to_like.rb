class AddLikeableToLike < ActiveRecord::Migration
  def change
    rename_column :likes, :status_id, :likeable_id
    add_column :likes, :likeable_type, :string

    Like.find_each do |like|
      like.update likeable_type: 'Status'
    end

    change_column_null :likes, :likeable_type, false
  end
end
