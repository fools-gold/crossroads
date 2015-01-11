class CreateIntegrations < ActiveRecord::Migration
  def change
    create_table :integrations do |t|
      t.string :webhook_url, null: false
      t.references :team, index: true, null: false

      t.timestamps null: false
    end
  end
end
