	root 'home#index'

	get '/' => 'home#index'
	post '/write' => 'home#write'