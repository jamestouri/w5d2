class PostsController < ApplicationController
  
  before_action :require_login!
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:sub_id]
    
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub_id)
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = current_user.posts.find(params[:id])
    
    if @post.update_attributes(post_params)
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to sub_url(@post.sub_id)
    end
  end
  
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
