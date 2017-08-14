class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:new, :create, :show, :edit]
  before_action :find_comment, only: [:show, :edit]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to comment_path(@comment.id, post_id: @post.id)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

  def find_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
