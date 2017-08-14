class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to @comment
    else
      render :new
    end
  end

  private

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
