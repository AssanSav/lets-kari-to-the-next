class Api::V1::SessionsController < ApplicationController

  def login 
    user = User.find_by(email: params[:email].capitalize) || User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {
        status: 200,
        loggedIn: true,
        user: UserSerializer.new(user),
        interests: user.interests
      }
    elsif user 
      render json: {
        status: 500,
        loggedIn: false,
        passwordError: ["*Wrong Password!"],
      }
    else
        render json: {
        status: 500,
        loggedIn: false,
        emailError: ["*Email Not Found!"]
      }
    end
  end

  def is_logged_in?
    if !!session[:user_id] && current_user
      render json: {
        loggedIn: true,
        user: UserSerializer.new(current_user),
        interests: current_user.interests,
        allInterests: Interest.all,
        users: User.all
      }
    else
        render json: {
          status: 409,
          loggedIn: false,
          message: "No Such User!",
          interests: Interest.all
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
