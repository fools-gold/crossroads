class AddStatusesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :statuses_count, :integer, null: false, default: 0

    User.find_each do |user|
      User.reset_counters user.id, :statuses
    end
  end
end
