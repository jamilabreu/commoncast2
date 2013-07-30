class PostsController < ApplicationController
  before_action :set_post, only: [:show, :vote_on]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @communities = params[:post][:community_ids]

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def show
  end

  def vote_on
    current_user.vote(@post, { direction: params[:direction], exclusive: true })
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params[:post].permit(:content, :community_ids)
    end
end