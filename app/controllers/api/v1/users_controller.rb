class Api::V1::UsersController < ApplicationController
  wrap_parameters :user, include: [:visibility, :password, :password_confirmation,:username, :email, :age, :image, :city, :gender, :orientation, :ethnicity, :height, :body_shape, :children, :relationship, :education, :bio,  :interest_ids]
  
  def index 
    users = User.all.where(visibility: true).order(created_at: :desc).where.not(id: current_user.id)
    if users 
      render json: {
        status: 200,
        users: UserSerializer.new(users),
        interests: Interest.all
      }
    end
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: {
        status: 200,
        user: UserSerializer.new(user),
        interests: user.interests
      }
    else 
      render json: {
        status: 409,
        passwordError: user.errors.messages[:password],
        password_confirmation_error: user.errors.messages[:password],
        username_error: user.errors.messages[:username],
        email_error: user.errors.messages[:email],
        gender_error: user.errors.messages[:gender],
        orientation_error: user.errors.messages[:orientation],
        interest_error: user.errors.messages[:interests]
      }
    end
  end

  def show 
    user = User.find(params[:id])
    if user 
      render json: {
        status: 200,
        user: UserSerializer.new(user),
        interests: user.interests
      }
    end
  end

   def update 
      user = User.find(params[:id])
      if user && user.update(user_params)
        render json: {
          status: 200,
          user: UserSerializer.new(user),
          interests: user.interests
        }
      else 
        render json: {
          status: 409,
          error: user.errors.full_messages
        }
      end
    end

  def my_matches
    if current_user
      matches = current_user.find_my_matches
      render json: {
        status: 200,
        matches: matches
      }
    else 
      render json: {
        message: ["No Match Foun!"]
      }
    end
  end

  def destroy 
    user = User.find(session[:user_id])
    if user && session.clear
      user.destroy
      render json: {
        status: 200,
        user: UserSerializer.new(user)
      }
      else 
        render json: {
          status: 500,
          error: user.errors.full_messages
        }
      end
  end

  private 

  def user_params 
    params.require(:user).permit(:visibility, :password, :password_confirmation,:username, :email, :age, :image, :city, :gender, :orientation, :ethnicity, :height, :body_shape, :children, :relationship, :education, :bio, interest_ids: [])
  end
   
end
