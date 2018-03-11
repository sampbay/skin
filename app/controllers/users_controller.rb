class UsersController < ApplicationController
	before_action :require_user_logged_out, only: [:new, :create]
	before_action :require_user, only: [:show, :edit, :update]
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id_session] = @user.id
			redirect_to new_profile_url(@profile)
		else
			render :new
		end
	end

	def show
		
		# @user = User.find(params[:id])
		#@user = current_user
		# rescue ActiveRecord::RecordNotFound
		# Skin Profile - acts as profiles_controller index
		@profile = Profile.find(current_user.profile)
		
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

	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
end
