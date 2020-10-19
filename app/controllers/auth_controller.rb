class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token
   
    def create
      @user = User.find_by(name: user_login_params[:username])
      #User#authenticate comes from BCrypt
      if @user && @user.authenticate(user_login_params[:password])
        # encode token comes from ApplicationController
        token = encode_token({ user_id: @user.id })
        render json: { user: @user, jwt: token, status: :accepted }
      else
        render json: { message: 'Invalid username or password' }, status: :unauthorized
      end
    end
   
    private
   
    def user_login_params
      # params { user: {username: 'Chandler Bing', password: 'hi' } }
      params.permit(:username, :password)
    end
  end