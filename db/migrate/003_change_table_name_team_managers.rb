class ChangeTableNameTeamManagers < ActiveRecord::Migration
  def change
        rename_table :teen_managers, :team_managers
    end 


end
