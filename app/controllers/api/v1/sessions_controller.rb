class Api::V1::SessionsController < ApplicationController

  def login 
    user = User.find_by(email: params[:email].capitalize) || User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {
        status: 200,
        user: UserSerializer.new(user),
        interests: user.interests
      }
    elsif user 
      render json: {
        status: 500,
        passwordError: ["*Wrong Password!"],
      }
    else
        render json: {
        status: 500,
        email_error: ["*Email Not Found!"]
      }
    end
  end

  def is_logged_in?
    if !!session[:user_id] && current_user
      render json: {
        logged_in: true,
        user: UserSerializer.new(current_user),
        interests: current_user.interests
      }
    else
        render json: {
          logged_in: false,
          message: "No Such User!"
        }
    end
  end

  def destroy 
    user = User.find(session[:user_id])
    if user && session.clear
      render json: {
        status: 200,
        user: user
      }
    end
  end

end
