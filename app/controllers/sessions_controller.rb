class SessionsController < ApplicationController
  before_action :require_user_logged_out, only: [:new, :create]
  before_action :require_user, only: [:destroy]
  def new; end

  def create
  	@user = User.find_by_email(params[:session][:email])
  	if @user && @user.authenticate(params[:session][:password])
  		if @user.email_confirmed
        session[:user_id_session] = @user.id
  		  redirect_to '/myproducts'
      else
        @login_error = 'Check your email inbox (or junk/spam folder) to activate your account and login!'
        render 'new'
      end
  	else
      @login_error = "Wrong email/password combination!"
  		render 'new'
  	end
  end

  def destroy
  	session[:user_id_session] = nil
  	redirect_to '/'
  end
end
