class ChangeVisitConstraint < ActiveRecord::Migration
  def change
    #removes erroneous uniqueness constraint
    remove_index :visits, :url_id
    add_index :visits, :url_id
  end
end
