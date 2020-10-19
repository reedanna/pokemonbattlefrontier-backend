class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token


    def index
        users = User.all

        render json: users.to_json(:include => { :pokemons => {:include => [:types, :species, {:moves => {:include => :type}}, :ability, :nature]}})
    end

    def show
        user = User.find(params[:id])

        render json: user.to_json(:include => { :pokemons => {:include => [:types, :species, {:moves => {:include => :type}}, :ability, :nature]}})
    end

    def create
        user = User.new(user_params)
        if user.valid?
            user.save
            token = encode_token(user_id: user.id)
            render json: { user: user, jwt: token, status: :created }
        else
            render json: { error: 'Username already taken. Please try a different one.' }, status: :not_acceptable
        end
    end

    def update
        user = User.find(params[:id])
        user.update(params)
    end

    private
    
    def user_params
        params.permit(:name, :password)
    end
end
