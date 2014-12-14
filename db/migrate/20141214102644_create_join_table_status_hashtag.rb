class CreateJoinTableStatusHashtag < ActiveRecord::Migration
  def change
    create_join_table :statuses, :hashtags do |t|
      t.index [:status_id, :hashtag_id], unique: true
      t.index [:hashtag_id, :status_id], unique: true
    end
  end
end
