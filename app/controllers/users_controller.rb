class UsersController < ApplicationController
  def index
    if params[:recent]
      @posts = Post.joins(:communities).where(community_posts: { community_id: current_user.community_ids }).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order(created_at: :desc)
    elsif params[:rewind]
      @posts = Post.joins(:communities).where("posts.created_at <= ?", DateTime.now - 1.week).where(approved: true, community_posts: {community_id: current_user.community_ids}).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order(created_at: :desc)
    else
      @posts = Post.joins(:communities).where(approved: true, communities: {id: current_user.community_ids}).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order('community_count DESC')
      @pending = Post.joins(:communities).where(approved: false, communities: { id: current_user.community_ids }).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order('community_count DESC')
      redirect_to root_path(recent: true) if @posts.blank? && @pending.blank? && Post.joins(:communities).where(community_posts: { community_id: current_user.community_ids }).select('posts.*, COUNT(distinct communities.id) AS community_count').having('COUNT(distinct communities.id) >= 2').group('posts.id').order(created_at: :desc).present? #TODO: scoped queries
    end
  end
end