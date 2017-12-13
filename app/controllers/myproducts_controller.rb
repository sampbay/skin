class MyproductsController < ApplicationController
#	before_action :require_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
#	before_action :require_user, only: [:index]
	def index
		#@myproduct = Myproduct.find(current_user.myproducts.product)
		#@myproduct = Myproduct.where(user: current_user.id)
		#rescue ActiveRecord::RecordNotFound
		# rescue b/c current_user.myproduct may be empty if first time user

		@safe_product = SafeProduct.where(user: current_user)
		@breakout_product = BreakoutProduct.where(user: current_user)
	
		@safe_product_manual = SafeProductManual.where(user: current_user)
		@breakout_product_manual = BreakoutProductManual.where(user: current_user)
	end
	#def new		
	    #@myproduct = Myproduct.new
	    #rescue ActiveRecord::RecordNotFound

#	    @safe_product = SafeProduct.new
#	    @breakout_product = BreakoutProduct.new
#	    rescue ActiveRecord::RecordNotFound
#	end	
#	def create
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
#		@safe_product = SafeProduct.new(safe_product_params)
#		@user_safe_product = UserSafeProduct.new(user: current_user, safe_product: @safe_product)
#		@safe_product.user = current_user

#		@breakout_product = BreakoutProduct.new(breakout_product_params)
#		@user_breakout_product = UserBreakoutProduct.new(user: current_user, breakout_product: @breakout_product)
#		@breakout_product.user = current_user
		
#		if @safe_product.save && @breakout_product.save
#			@user_safe_product.save
#			@user_breakout_product.save
#			redirect_to '/myproducts'
#		else 
#			redirect_to 'new'
#		end
#	end
#	def show
		#@myproduct = Myproduct.find(current_user.myproduct)
		#@product = params[:array_element] 
		#if Product.where(:brand => params[:array_element]).blank?
		
		#if Product.exists?(params[:array_element])
		#	@product = params[:array_element]
		#else 
		#	redirect_to '/myproducts'
		#end
#	end
#	def edit
#		@myproduct = Myproduct.find(current_user.myproduct)		
#		@products = Product.all
#		rescue ActiveRecord::RecordNotFound
#	end
#	def update
		#@myproduct = Myproduct.find(current_user.myproduct)
		#if @myproduct.products.
		#if @myproduct.save
		#	redirect_to '/myproducts'
		#else 
		#	redirect_to 'new'
		#end

	#	@myproduct.product_safe << params[:myproduct][:product_safe]
#		@myproduct.product_breakout << params[:myproduct][:product_breakout]
		#if @myproduct.products.include? params[:myproduct][:products]
		#	flash[:notice] = "This product already exists in My Products!"
		#	redirect_to '/myproducts'
		#else
		#	Myproduct.find_by_sql(["UPDATE myproducts SET products = array_append(products, ?) WHERE user_id = ?", params[:myproduct][:products], current_user]);
		#	redirect_to '/myproducts'
		#end
		#Myproduct.find_by_sql(["UPDATE myproducts SET product_breakout = array_append(product_breakout, ?) WHERE user_id = ?", params[:myproduct][:product_breakout].split(","), current_user]) if params[:myproduct][:product_breakout] != nil;	

#		@myproduct = Myproduct.find(current_user.myproduct)
#		if @myproduct.update(myproduct_params) 
#			redirect_to '/profiles'
#		else 
#			render 'edit'
#		end
#	end
#	def destroy
#		@myproduct = Myproduct.find(params[:id])
#		@myproduct.destroy
#		redirect_to '/myproducts'
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET products = array_remove(products, ?) WHERE user_id = ?", params[:array_element], current_user]);
		# when it was array: Myproduct.find_by_sql(["UPDATE myproducts SET product_breakout = array_remove(product_breakout, ?) WHERE user_id = ?", params[:array_element], current_user]);
#	end
	
	

	
end
