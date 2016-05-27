Rails.application.routes.draw do
  root 'board#index'
  get 'board/index'
  post 'board/create'
  get 'board/new'
  get 'board/edit'
  get 'board/destroy'
  post 'board/:post_id/comment_create' => 'board#comment_create'
end