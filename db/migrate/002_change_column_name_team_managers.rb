class ChangeColumnNameTeamManagers < ActiveRecord::Migration
  def up
  	rename_column :teen_managers, :user_id_id, :user_id

  end

  def down
  end
end
