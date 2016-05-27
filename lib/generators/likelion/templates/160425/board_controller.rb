class BoardController < ApplicationController
  def index
    @post = Post.all
  end

  def create
    @post = Post.new(title: params[:title], content: params[:content])
    @post.save
    redirect_to :back
  end

  def new
  end

  def edit
  end

  def destroy
  end
  def comment_create
    @comment = Comment.new(post_id: params[:post_id], content: params[:content])
    @comment.save
    redirect_to :back
  end
end