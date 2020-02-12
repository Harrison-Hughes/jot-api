class UsersController < ApplicationController
  
  def signin
    user = User.find_by(email: user_params[:email])
    if user and user.authenticate(user_params[:password])
      render json: user
    else
      render json: { error: 'email/password combo invalid' }, status: :not_acceptable
    end
  end

  def signup
    if user_params[:password] == user_params[:password_confirmation]
      default_nickname = user_params[:email].split("@")[0]
      user = User.new(email: user_params[:email], password: user_params[:password], default_nickname: default_nickname)
      if user.save
        user.update(user_code: generateUserCode)
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
      render json: {error:'validation failed'}, status: 418
    end
  end

  def updateDefaultNickname
    user = User.find_by(id: params[:user_id])
    user.update_attribute(:default_nickname, user_params[:default_nickname])
    render json: user
  end

  private

  def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :default_nickname)
  end

  def generateUserCode
    user_codes = User.all.map{ |p| p.user_code}
    searching = true
    while searching
      code = SecureRandom.hex(3)
      searching = user_codes.include? code
    end
    return code
  end

end