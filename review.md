### One to Many
- Implement the Post model and controller
          bin/rails g resources post title body:text
- Implement the Comment model and controller
          bin/rails g resource comment post:references body:text

          class Comment < ActiveRecord::Base
          belongs_to :post
          end
- Set up the associations on the Post model
          class Post < ActiveRecord::Base
          has_many :comments, dependent: :destroy
          end
- Implement comment creation form

        <h2>Add a comment</h2>
        <%= form_for [@post, @comment] do |f| %>
        <div>
        <%= f.label :body %>
        <%= f.text_area :body %>
        </div>
        <%= f.submit %>
        <% end %>

        Rails.application.routes.draw do
        <!-- resources :comments -->
        <!-- resources :posts -->
        resources :posts do
          resources :comments
        end

- Implement the comment create action

      def create
          @post          = Post.find params[:post_id]
          comment_params = params.require(:comment).permit(:body)
          @comment       = Comment.new comment_params
          @comment.post  = @post
          if @comment.save
            redirect_to post_path(@post), notice: "Comment created"
          else
            render "/posts/show"
          end
        end
