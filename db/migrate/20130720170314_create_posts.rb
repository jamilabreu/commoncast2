class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :image
      t.text :content, null: false
      t.boolean :approved, default: false
      t.boolean :promoted, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
