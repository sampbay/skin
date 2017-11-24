class ProductsController < ApplicationController
	def index; end

	def show 
		@product = Product.find(params[:id])
		rescue ActiveRecord::RecordNotFound

	end


def favorite
  @product = Product.find(params[:id])

  if request.put?
      current_user.favorites << @product
      redirect_to '/favorites'
  elsif request.delete?
      current_user.favorites.delete(@product)
      redirect_to '/favorites'
  else
      redirect_to '/favorites'
  end    
end
end