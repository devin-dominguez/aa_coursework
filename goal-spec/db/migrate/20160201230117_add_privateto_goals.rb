class AddPrivatetoGoals < ActiveRecord::Migration
  def change
    add_column :goals, :private, :boolean, default: true, null: false
  end
end
