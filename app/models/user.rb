class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

  has_many :posts
  has_many :community_users
  has_many :communities, through: :community_users

  validates :email, presence: true, uniqueness: true
  validate  :number_of_communities

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
  end
end
