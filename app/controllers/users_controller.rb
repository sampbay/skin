class UsersController < ApplicationController
	before_action :require_user_logged_out, only: [:new, :create, :confirm_email]
	before_action :require_user, only: [:show, :edit, :update]
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.set_confirmation_token
			@user.save(validate: false)            
			UserMailer.registration_confirmation(@user).deliver_now 
  			redirect_to "/activate"
			#session[:user_id_session] = @user.id
			#redirect_to '/myproducts'
		else
			@login_error = "Invalid, please try again"
			render :new
		end
	end

	def show
		# @user = User.find(params[:id])
		@user = current_user
	end

	def edit
		# @user = User.find(params[:id])
		@user = current_user

	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params) 
			redirect_to @user
		else 
			render 'edit'
		end
	end

	def confirm_email
	    user = User.find_by_confirm_token(params[:token])
	    if user
	    	user.validate_email
	    	user.save(validate: false)
	    	redirect_to user
	    else
	    	@login_error = "Sorry. User does not exist"
	    	redirect_to root_url
	    end
	end

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
end
