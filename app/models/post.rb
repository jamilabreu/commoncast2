class Post < ActiveRecord::Base
  acts_as_voteable
  belongs_to :user
  has_many :community_posts
  has_many :communities, through: :community_posts

  validates :content, presence: true
  validate :number_of_communities

  def community_ids=(string)
    self.communities.delete_all if self.communities.present?
    array = string.split(",") - ["[]"]
    array.each do |input|
      existing = Community.find_by(id: input)
      @community = existing.blank? ? Community.create(name: input, slug: input.parameterize, hashtag: "##{input.parameterize}") : existing
      self.communities << @community
    end
  end

  def number_of_communities
    errors.add(:communities, "please select at least 2") if self.communities.length < 2
    errors.add(:communities, "please select a maximum of 4") if self.communities.length > 4
  end
end
