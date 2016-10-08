Rails.application.routes.draw do

  namespace :my do
    get 'friends', to: 'friends#index'
    get 'posts', to: 'posts#index'
    get 'direct_messages', to: 'posts#direct'
  end

  get 'home/index'
  # posts_by_user_path
  get 'posts/:username', constraints: { username: /[a-zA-Z.\/0-9_\-]+/ }, :to => "posts#by_user", :as => :posts_by_user
  # Used in gon variable... Be sure to change there too
  get 'tags/:tag', constraints: { tag: /[a-zA-Z.\/0-9_\-]+/ }, :to => "posts_by_tag#posts", :as => :posts_by_tag
  resources :posts
  resources :posts_by_tag
  resources :topics
  resources :friendships
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
