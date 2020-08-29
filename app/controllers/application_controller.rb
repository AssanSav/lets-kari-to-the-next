class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token 
  helper_method :current_user, :authorized_user?

  def current_user 
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end 

  def authorized_user?
    @user == current_user
  end
end
