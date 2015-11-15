class CommentsMailer < ApplicationMailer

  def notify_post_owner(comment)
    @user = comment.user
    @post = comment.post
    mail(to: @post.user.email, subject: "#{@user.full_name} commented on your post")
  end
end

# def notify_question_owner_answer(answer)
#     @answer   = answer
#     @question = answer.question
#     @owner    = @question.user
#     mail(to: @owner.email, subject: "You got a new answer!")
#   end
