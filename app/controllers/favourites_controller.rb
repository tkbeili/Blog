class FavouritesController < ApplicationController
  before_action :authenticate_user

  def create
    favourite       = Favourite.new
    post            = Post.friendly.find params[:post_id]
    favourite.post  = post # taking the post(post_id) and setting it to favourite.post(post_id) on the favourite table
    favourite.user  = current_user # taking the current_user(user_id) and setting it to favourite.user(user_id) on the favourite table
    if favourite.save
      FavouritesMailer.delay(run_at: Date.today.noon + 10.hours).notify_post_owner_for_favourites(favourite)
      redirect_to post_path(post)
    else
      redirect_to post_path(post), notice: "Already favourited!"
    end
  end

  def index
    @favourites = current_user.favourites
  end

# /posts/:post_id/favourites/:id
  def destroy
    post        = Post.friendly.find params[:post_id]
    favourite   = current_user.favourites.find params[:id]
    favourite.destroy
    redirect_to post_path(post)
  end

end
