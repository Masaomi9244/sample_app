Rails.application.routes.draw do
  ##############
  ###  投稿  ###
  #############
  get  'posts/index'        => 'posts#index'
  get  'posts/new'          => 'posts#new'
  get  'posts/:id'          => 'posts#show'
  get  'posts/:id/edit'     => 'posts#edit'
  post 'posts/create'       => 'posts#create'
  post 'posts/:id/update'   => 'posts#update'
  post 'posts/:id/destroy'  => 'posts#destroy'

  ###############
  ###  ユーザ  ###
  ###############
  get  'login'              => 'users#login_form'
  get  'users/index'        => 'users#index'
  get  'users/:id/show'     => 'users#show'
  get  'users/:id/edit'     => 'users#edit'
  get  'users/signup'       => 'users#new'
  get  'users/:id/likes'    => 'users#likes'
  post 'login'              => 'users#login'
  post 'logout'             => 'users#logout'
  post 'users/create'       => 'users#create'
  post 'users/:id/update'   => 'users#update'
  post 'users/:id/destroy'  => 'users#destroy'

  ###############
  ###  いいね  ###
  ###############
  post 'likes/:post_id/create'  => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'

  ###############
  ###  その他  ###
  ###############
  get "/"     => 'home#top'
end
