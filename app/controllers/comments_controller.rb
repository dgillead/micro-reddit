class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.save
  end

  private

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
