class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show]
  respond_to :html, :json

  # GET /communities/search.json
  def search
    query = params[:query].try(:delete, "#")
    results = query.present? ? Community.where("slug ILIKE '%#{query}%'") : Community.all.order(:slug)
    @communities = results.blank? ? [{id: query, hashtag: "##{query.parameterize}", type: nil}] : results

    respond_with @communities, only: [:id, :hashtag, :type], callback: params[:callback]
  end

  # GET /communities/preload.json
  def preload
    @communities = current_user.communities

    respond_with @communities, only: [:id, :hashtag, :type], callback: params[:callback]
  end

  def index
    @communities = Community.all
  end

  def show
    if params[:recent]
      @posts = @community.posts.order(created_at: :desc)
    else
      @posts = @community.posts.joins(:communities).where(approved: true, communities: {id: current_user.community_ids}).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order('community_count DESC')
      @pending = @community.posts.joins(:communities).where(approved: false, communities: { id: current_user.community_ids }).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order('community_count DESC')
    end
  end

  private
    def set_community
      @community = Community.find(params[:id])
    end
end