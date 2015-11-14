class CommentsController < ApplicationController
before_action :authenticate_user, except:[:index, :show]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(find_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to post_path(@post), notice: "Comment added. Wee!"
    else
      flash[:alert] = @comment.errors.full_messages.join(", ")
      render "posts/show"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    redirect_to post, alert: "Access denied!" unless can?(:destroy, comment)
    comment.destroy
    redirect_to post_path(comment.post), notice: "Comment Deleted"
  end

  private

  def find_params
    params.require(:comment).permit(:body)
  end
end
