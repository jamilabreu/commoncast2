class CreateCommunityPosts < ActiveRecord::Migration
  def change
    create_table :community_posts do |t|
      t.references :community, index: true
      t.references :post, index: true

      t.timestamps
    end
  end
end
