class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.text :description, null:false
      t.references :user, index: true, null:false

      t.timestamps
    end
  end
end
