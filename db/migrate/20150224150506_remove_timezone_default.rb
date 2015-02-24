class RemoveTimezoneDefault < ActiveRecord::Migration
  def up
    change_column_default :users, :timezone, nil
  end

  def down
    change_column_default :users, :timezone, 'UTC'
  end
end
