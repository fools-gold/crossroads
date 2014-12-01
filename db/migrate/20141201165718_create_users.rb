class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :title
      t.references :team, index: true, null: false

      t.timestamps
    end
    add_index :users, [:team_id, :email], unique: true
  end
end
