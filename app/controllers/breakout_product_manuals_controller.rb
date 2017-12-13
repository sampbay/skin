class BreakoutProductManualsController < ApplicationController

	#before_action :require_user, only: [:new, :create, :show, :destroy]
	def new		
	    #@myproduct = Myproduct.new
	    #rescue ActiveRecord::RecordNotFound

		
	    @breakout_product_manual = BreakoutProductManual.new
	    rescue ActiveRecord::RecordNotFound
	    
	end	
	def create
		@breakout_product_manual = BreakoutProductManual.new(breakout_product_params)
		@breakout_product_manual.user = current_user
		if @breakout_product_manual.save
			redirect_to '/myproducts'
		else 
			redirect_to '/myproducts'
		end
	end
	# show action added to display manually added product info when clicked on myproducts page
	def show 
		@breakout_product_manual = BreakoutProductManual.find(params[:id])
	end

	def destroy
		@breakout_product_manual = BreakoutProductManual.find(params[:id])
		@breakout_product_manual.destroy
		redirect_to '/myproducts'
	end

	private
	
	def breakout_product_params
		params.require(:breakout_product_manual).permit(:brand, :product, :product_type, :ingredients)
	end

end

