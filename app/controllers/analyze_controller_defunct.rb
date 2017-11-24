class AnalyzeController < ApplicationController

	before_action :require_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
	before_action :check_profile_presence, only: [:new, :create]
	def index
		#@myproduct = Myproduct.find(current_user.myproducts)
		@myproduct = Myproduct.where(user: current_user.id)
		
		@safe_product_list = SafeProduct.where(user: current_user.id)
		@breakout_product_list = BreakoutProduct.where(user: current_user.id)
	#end
	#def new
	#   @myproduct = Myproduct.where(user: current_user.id)	
	    @safe_product = SafeProduct.new
	    @breakout_product = BreakoutProduct.new
	    rescue ActiveRecord::RecordNotFound
	end	
	def create
		@safe_product = SafeProduct.new(safe_product_params)
		@user_safe_product = UserSafeProduct.new(user: current_user, safe_product: @safe_product)
		@safe_product.user = current_user

		@breakout_product = BreakoutProduct.new(breakout_product_params)
		@user_breakout_product = UserBreakoutProduct.new(user: current_user, breakout_product: @breakout_product)
		@breakout_product.user = current_user
		
		if @safe_product.save && @breakout_product.save
			@user_safe_product.save
			@user_breakout_product.save
			redirect_to '/myproducts'
		else 
			redirect_to 'new'
		end
	end
	#def edit
		#@myproduct = Myproduct.find(current_user.myproducts)	
	#	@myproduct = Myproduct.where(user: current_user.id)	
		
	#	@products = Product.all
	#	@profile = Profile.find(current_user.profile)
	#	rescue ActiveRecord::RecordNotFound

	#end
	#def update
	#	@myproduct = Myproduct.find(current_user.myproduct)
		

	#	 @myproduct.save
	 #   	redirect_to '/results'
#		else 
		#	redirect_to 'new'
		#end

		#@myproduct.products_safe << params[:product_safe]
		#@myproduct.products_breakout << params[:product_breakout]
		
	#	Myproduct.find_by_sql(["UPDATE myproducts SET products_safe = ARRAY[?]::citext[] WHERE user_id = ?", params[:products_safe] ||= [], current_user]);
	#	Myproduct.find_by_sql(["UPDATE myproducts SET products_breakout = ARRAY[?]::citext[] WHERE user_id = ?", params[:products_breakout] ||= [], current_user]);
		
		#worked append 20170304 -> Myproduct.find_by_sql(["UPDATE myproducts SET products_breakout = products_breakout || ARRAY[?]::citext[] WHERE user_id = ?", params[:products_breakout] ||= [], current_user]);
		#Myproduct.find_by_sql(["UPDATE myproducts SET product_breakout = array_append(product_breakout, ?) WHERE user_id = ?", params[:myproduct][:product_breakout].split(","), current_user]) if params[:myproduct][:product_breakout] != nil;	


		#@myproduct = Myproduct.find(current_user.myproduct)
		#if @myproduct.update(myproduct_params) 
		#	redirect_to '/profiles'
		#else 
		#		render 'edit'
		#	end
	#end
	
	private
	#def myproduct_params
		# json_params = ActionController::Parameters.new(products: [ :product, :breakout ])
		# json_params.require(:profile).permit(products: [ :product, :breakout ])
		#params.require(:myproduct).permit(:product)
	#end
	def safe_product_params
		params.require(:safe_product).permit(:product)
	end
	def breakout_product_params
		params.require(:breakout_product).permit(:product)
	end
	def check_profile_presence
		redirect_to '/profiles' if Profile.exists?(current_user.profile)
	end
end


