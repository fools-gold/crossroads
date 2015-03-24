class RemoveStatusNullInLike < ActiveRecord::Migration
  def change
    remove_column :likes, :status_id, :integer
  end
end
