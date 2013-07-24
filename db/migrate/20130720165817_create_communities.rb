class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.string :slug, null: false, unique: true
      t.string :hashtag, null: false
      t.boolean :approved, default: false
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
