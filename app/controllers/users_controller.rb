class UsersController < ApplicationController
  
  def signin
    user = User.find_by(email: user_params[:email])
    if user and user.authenticate(user_params[:password])
      render json: user
    else
      render json: { error: "email/password combo invalid." }, status: 401
    end
  end

  def signup
    if user_params[:password] == user_params[:password_confirmation]

      user = User.new(email: user_params[:email], password: user_params[:password])
      if user.save
        user.update(user_code: generateUserCode(user.id))
        render json: user
      else
        render json: { error: user.errors.full_messages }, status: 403
      end

    else
      render json: { error: 'passwords do not match' }, status: 403
    end 
  end

  def validate
    if logged_in?
      render json: @current_user
    else
      render json: {message:'validation failed'}, status: 418
    end
  end

  private

  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
  end 

  def generateUserCode(id)
    id
  end

end