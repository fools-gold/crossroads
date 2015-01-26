class AddForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :users, :teams, on_delete: :cascade
    add_foreign_key :statuses, :users, on_delete: :cascade
    add_foreign_key :hashtags_statuses, :hashtags, on_delete: :cascade
    add_foreign_key :hashtags_statuses, :statuses, on_delete: :cascade
  end
end
