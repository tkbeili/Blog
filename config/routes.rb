Rails.application.routes.draw do

resources :posts
# get "/posts/new"        => "posts#new", as: :new_post
# post "/posts"           => "posts#create", as: :posts
# get "/posts/:id"        => "posts#show", as: :post
# get "/posts:id/edit"    => "posts#edit", as: :edit_post
# patch "/posts/:id"      => "posts#update"
# get "/posts"            => "posts#index"
# delete "/posts/:id"     => "posts#destroy"
# get "/posts"              => "posts#search", as: :search

root "posts#index"

resources :users, only:[:new, :create]

resources :sessions, only:[:new, :create] do
  delete :destroy, on: :collection
end

resources :posts do
    member do
      post :vote_up
      post :vote_down
    end

    post :search, on: :collection

    resources :comments

    resources :favourites, only:[:create, :destroy, :index]

  end

  # resources :snippets, only:[] do
  # resources :comments
end
