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

  private
    def post_params
      params[:post].permit(:content, :community_ids)
    end
end