Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  post 'write' => "home#write"
  get '/list' => "home#list"
  get 'destroy/:post_id' => "home#destroy"
  get 'update_view/:post_id' => "home#update_view"
  post 'update/:post_id' => "home#update"
end