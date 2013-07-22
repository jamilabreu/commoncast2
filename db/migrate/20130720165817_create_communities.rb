class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name, null: false
      t.string :slug, null: false, unique: true
      t.string :hashtag, null: false
      t.string :type
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
