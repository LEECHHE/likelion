class HomeController < ApplicationController
	def index
	end
	def write
		@almond = params[:title]
		@anchovy = params[:content]
	end
end