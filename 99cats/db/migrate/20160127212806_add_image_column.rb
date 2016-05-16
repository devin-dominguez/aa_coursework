class AddImageColumn < ActiveRecord::Migration
  def change
    add_column :cats, :image_html, :string
  end
end
