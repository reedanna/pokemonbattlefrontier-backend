class UsersController < ApplicationController
    def index
        users = User.all

        render json: users.to_json(:include => { :pokemons => {:include => [:types, :species, {:moves => {:include => :type}}, :ability, :nature]}})
    end

    def show
        user = User.find(params[:id])

        render json: user.to_json(:include => :pokemons)
    end

    def create
        user = User.new(user_params)

        user.save
        render json: user.to_json
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
