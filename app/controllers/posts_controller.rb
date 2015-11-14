class PostsController < ApplicationController
  before_action :find_post, {only:[:show, :edit, :update, :destroy]}
  before_action  :authenticate_user, except: [:index, :show]
  before_action :authorize, only: [:edit, :update, :destroy]
  def index
    @post = Post.search(params[:search]).page(params[:page] || 1).per(3).order(vote_counter: :desc)
    # @post = Post.search(params[:search])
  end

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit([:title, :body, {tag_ids:[]}])
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
     redirect_to(post_path(@post))
   else
     render :new
   end
  end

  def show
     @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    # @post = Post.find(params[:id])
    redirect_to posts_path, alert: "Access denied!" unless can? :edit, @post
  end

  def update
    # @post = Post.find(params[:id])
    post_params = params.require(:post).permit([:title, :body])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Post updated!"
    else
      render :edit
    end
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "Post Deleted"
  end

  def vote_up
    @post = Post.find params[:id]
    @post.increment!(:vote_counter)
    # session[:has_voted] = true
    redirect_to post_path
  end
  def vote_down
    @post = Post.find params[:id]
    @post.decrement!(:vote_counter)
    # session[:has_voted] = true
    redirect_to post_path
  end

  def authorize
    redirect_to root_path, alert: "Access Denied!" unless can? :manage, @post
  end

private


 def find_post
   @post = Post.find(params[:id])
 end

end
