class BreakoutProductsController < ApplicationController
	before_action :require_user, only: [:new, :create, :destroy]
	def new		
	    #@myproduct = Myproduct.new
	    #rescue ActiveRecord::RecordNotFound

	
	    @breakout_product = BreakoutProduct.new
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
		

		@breakout_product = BreakoutProduct.where(user: current_user)
		@breakout_product_manual = BreakoutProductManual.where(user: current_user)

		if (@breakout_product.count + @breakout_product_manual.count) < 10 
			@breakout_product = BreakoutProduct.new(breakout_product_params)
			@user_breakout_product = UserBreakoutProduct.new(user: current_user, breakout_product: @breakout_product)
			@breakout_product.user = current_user
			
			if @breakout_product.save

				@user_breakout_product.save
				redirect_to '/myproducts'
			else 
				redirect_to '/myproducts'
			end
		else 
			redirect_to '/myproducts'
		end
	end

def destroy
		@breakout_product = BreakoutProduct.find(params[:id])
		@breakout_product.destroy
		redirect_to '/myproducts'
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET products = array_remove(products, ?) WHERE user_id = ?", params[:array_element], current_user]);
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET product_breakout = array_remove(product_breakout, ?) WHERE user_id = ?", params[:array_element], current_user]);
	end


	private
	
	def breakout_product_params
		params.require(:breakout_product).permit(:product)
	end
end
