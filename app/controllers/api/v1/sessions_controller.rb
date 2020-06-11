class SessionsController < ApplicationController

    def signup 
        user = User.create!(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: {
                status: 200,
                user: UserSerializer.new(user)
            }
        else 
            render json: {
                status: 409,
                error: user.errors.full_messages
            }
        end
    end

    def login 
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: {
                status: 200,
                user: UserSerializer.new(user)
            }
        else 
            render json: {
                status: 409,
                error: user.errors.full_messages
            }
        end
    end

    def is_logged_in?
        if !!session[:user_id] && current_user
            render json: {
                logged_in: true,
                user: UserSerializer.new(current_user)
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
        if user 
            session.clear
            render json: {
                status: 200,
                logout: true
            }
        end
    end

    private 

    def user_params 
        params.require(:session).permit(name, username, password, password_confirmation)
    end
end
