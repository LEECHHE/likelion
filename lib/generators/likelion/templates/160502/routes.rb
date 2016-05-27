Rails.application.routes.draw do
  get 'home/index'
  post 'write' => "home#write"
  post '/home/reply_write' => "home#reply_write"
end