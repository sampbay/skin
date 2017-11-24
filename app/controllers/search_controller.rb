class SearchController < ApplicationController
	before_action :require_user, only: [:new, :create, :destroy]
before_action :require_user_profile_nil, only: [:edit, :update, :destroy]
	# new & create acting like edit and update
	def edit
		@products = Product.all
		
	    @profile = Profile.find(current_user.profile)
	    
	    #3.times { @profile.products.build }
	    # @product_search = Product.find_by_sql "SELECT row_to_json(row(name, brand)) FROM products"
		
	end	
	def update
		@profile = Profile.find(current_user.profile)

		if @profile.update(profile_params)
			redirect_to '/profiles'
		else
			render 'edit'
		end
	end
	# def edit
	#	@profile = Profile.find(params[:id])

	#end
	#def update
	#	@profile = Profile.find(params[:id])
	#	if @profile.update(products_params) 
	#		redirect_to @profile
	#	else 
	#		render 'edit'
	#	end
	#end
	def destroy
		@profile = Profile.find(params[:id])
		@profile.destroy
		redirect_to profiles_path
	end
	
	private
	def profile_params
		# json_params = ActionController::Parameters.new(products: [ :product, :breakout ])
		# json_params.require(:profile).permit(products: [ :product, :breakout ])
		params.require(:profile).permit(:product_breakout_nil => [], :product_breakout => [])
	end
end

 