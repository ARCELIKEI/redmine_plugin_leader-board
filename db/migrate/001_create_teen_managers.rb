class CreateTeenManagers < ActiveRecord::Migration
  def change
    create_table :teen_managers do |t|
      t.string :title
      t.references :user_id
    end
  end
end
