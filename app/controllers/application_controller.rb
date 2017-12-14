require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
  	@current_user ||=  User.find(1)
    rescue ActiveRecord::RecordNotFound
  end

  def require_user
  	redirect_to '/login' unless current_user
  end

  def require_user_logged_out
  	redirect_to '/myproducts' if current_user
  end

  #def require_user_profile_exists
  #  redirect_to '/profiles' unless @profile
  #end

  #def require_user_profile_nil
  #  redirect_to '/profiles' if @profile
  #end
end
