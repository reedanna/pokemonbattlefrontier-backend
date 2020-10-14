class PokemonMovesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        pokemon_moves = PokemonMove.all

        render json: pokemon_moves
    end

    def show 
        
    end

    def create
        pokemon_move = PokemonMove.create(pokemon_move_params)
        pokemon_move.save

        render json: pokemon_move
    end

    def destroy
        pokemon_move = PokemonMove.find(params[:id])
        pokemon_move.destroy

    end


    private
    
    def pokemon_move_params
        params.permit(:pokemon_id, :move_id)
    end
end
