class HomeController < ApplicationController
	def index
	end
	def write
		@title = params[:title]
		@receiver = params[:email]
		@content = params[:content]
	end
end