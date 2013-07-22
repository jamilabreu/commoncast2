class Community < ActiveRecord::Base
  self.inheritance_column = nil #TEMP?
  has_many :community_users
  has_many :community_posts
  has_many :users, through: :community_users
  has_many :posts, through: :community_posts
end
