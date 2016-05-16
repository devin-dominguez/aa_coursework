class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :user_id, null: false
      t.integer :author_id, null: false
      t.text :body, null: false
      
      t.timestamps null: false
    end
  end
end
