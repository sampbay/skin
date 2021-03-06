class SafeProductsController < ApplicationController
	before_action :require_user, only: [:new, :create, :destroy]
	def new		
	    #@myproduct = Myproduct.new
	    #rescue ActiveRecord::RecordNotFound

	    @safe_product = SafeProduct.new
	    
	    rescue ActiveRecord::RecordNotFound
	end	
	def create
		#@myproduct = Myproduct.new(myproduct_params)
		#@user_myproduct = UserMyproduct.new(user: current_user, myproduct: @myproduct)
		#@myproduct.user = current_user			
		#	if @myproduct.save
				#current_user.myproducts.create(myproduct_params)
		#		@user_myproduct.save
		#		redirect_to '/myproducts'
		#	else 
		#		redirect_to 'new'
		#	end
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET products = array_append(products, ?) WHERE user_id = ?", params[:myproduct][:products], current_user]);
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET product_breakout = array_append(product_breakout, ?) WHERE user_id = ?", params[:myproduct][:product_breakout], current_user]);
		@safe_product = SafeProduct.new(safe_product_params)
		@user_safe_product = UserSafeProduct.new(user: current_user, safe_product: @safe_product)
		@safe_product.user = current_user

		
		
		if @safe_product.save 
			@user_safe_product.save
	
			redirect_to '/myproducts'
		else 
			redirect_to '/myproducts'
		end
	end

def destroy
		@safe_product = SafeProduct.find(params[:id])
		@safe_product.destroy
		redirect_to '/myproducts'
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET products = array_remove(products, ?) WHERE user_id = ?", params[:array_element], current_user]);
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET product_breakout = array_remove(product_breakout, ?) WHERE user_id = ?", params[:array_element], current_user]);
	end




private

	def safe_product_params
		params.require(:safe_product).permit(:product)
	end
	
end
