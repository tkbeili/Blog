class FavouritesMailer < ApplicationMailer

  def notify_post_owner_for_favourites(favourite)
    @user = favourite.user
    @post = favourite.post
    mail(to: @post.user.email, subject: "#{@user.full_name} favourited your post!")
  end
end
