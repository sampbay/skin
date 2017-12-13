class FavoritesController < ApplicationController
	#before_action :require_user, only: [:index]
	def index
		@favorite_products = FavoriteProduct.where(user: current_user)
		@products = Product.all
	end
	
end
