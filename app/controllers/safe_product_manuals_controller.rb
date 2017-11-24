class SafeProductManualsController < ApplicationController

	before_action :require_user, only: [:new, :create, :show, :destroy]
	def new		
	    #@myproduct = Myproduct.new
	    #rescue ActiveRecord::RecordNotFound

		
	    @safe_product_manual = SafeProductManual.new
	    rescue ActiveRecord::RecordNotFound
	    
	end	
	def create
		@safe_product_manual = SafeProductManual.new(safe_product_params)
		@safe_product_manual.user = current_user
		if @safe_product_manual.save
			redirect_to '/myproducts'
		else 
			redirect_to '/myproducts'
		end
	end
	# show action added to display manually added product info when clicked on myproducts page
	def show 
		@safe_product_manual = SafeProductManual.find(params[:id])
	end
	def destroy
		@safe_product_manual = SafeProductManual.find(params[:id])
		@safe_product_manual.destroy
		redirect_to '/myproducts'
	end

	private
	
	def safe_product_params
		params.require(:safe_product_manual).permit(:brand, :product, :product_type, :ingredients)
	end

end

