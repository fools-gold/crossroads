class AddDescriptionToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :description, :text, null: false, default: ""
  end
end
