class PostsController < ApplicationController
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

  def vote_on
    @post = Post.find(params[:id])
    current_user.vote(@post, { direction: params[:direction], exclusive: true })
  end

  private
    def post_params
      params[:post].permit(:content, :community_ids)
    end
end