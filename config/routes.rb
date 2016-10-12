Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  get 'chat', to: 'messages#index'
  get 'messages', to: 'messages#index'
  namespace :my do
    get 'friends', to: 'friends#index'
    get 'posts', to: 'posts#index'
    get 'direct_messages', to: 'posts#direct'
  end

  get 'home/index'
  # posts_by_user_path
  get 'posts/by/user/:username', constraints: { username: /[a-zA-Z.\/0-9_\-]+/ }, :to => "posts_by_user#index", :as => :posts_by_user
  # Used in gon variable... Be sure to change there too
  get 'posts/by/tag/:tag', constraints: { tag: /[a-zA-Z.\/0-9_\-]+/ }, :to => "posts_by_tag#posts", :as => :posts_by_tag
  # get 'tags/:tag', constraints: { tag: /[a-zA-Z.\/0-9_\-]+/ }, :to => "posts_by_tag#posts", :as => :posts_by_tag
  resources :posts
  resources :posts_by_tag
  resources :topics
  resources :friendships
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
