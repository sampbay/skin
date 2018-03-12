class ProfilesController < ApplicationController
	#before_action :require_user, only: [:index, :new, :create, :edit, :update, :destroy]
	#before_action :check_profile_presence, only: [:new, :create]
	#before_action :require_user_profile_exists, only: [:edit, :update, :destroy]
	#before_action :require_user_profile_nil, only: [:new, :create]
	def welcome; end
	def index
		@profile = Profile.find(current_user.profile)
	#	@myproduct = Myproduct.find(current_user.myproducts)
		# @parsed_products = JSON.parse(@profile.products)
		rescue ActiveRecord::RecordNotFound
	end	
	#def show
	#	@profile = Profile.find(params[:id])
		# show ingredients by ingredients controller
	#end
	def new
		@profile = Profile.new
	    # 3.times { @profile.products.build }
	    # @product_search = Product.find_by_sql "SELECT row_to_json(row(name, brand)) FROM products"
		
	end
	def create
		@profile = Profile.new(profile_params)
		@profile.user = User.find(current_user)
		if @profile.save
			redirect_to '/myproducts'
		end
		
	end
	def edit
		@profile = Profile.find_by(user_id: current_user)
		# @myproduct = Myproduct.find(current_user.myproducts)

	end
	def update
		@profile = Profile.find_by(user_id: current_user)
		#@profile = Profile.find(current_user.profile)
		if @profile.update(profile_params) 
			redirect_to '/myproducts'
		else 
			render 'edit'
		end
	end
	def destroy
		@profile = Profile.find(params[:id])
		@profile.destroy
		redirect_to '/myproducts'
	end
	
	private
	def profile_params
				# in case user sends empty array (i.e. remove all checkbox)
		params[:profile][:concerns] ||= []
		params.require(:profile).permit(:age, :skin_type, :ethnicity, :user, {:concerns => []})
	end

	def check_profile_presence
		redirect_to current_user if Profile.exists?(current_user.profile)
	end
end
