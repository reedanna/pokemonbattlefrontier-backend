class PokemonsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        pokemons = Pokemon.all

        render json: pokemons.to_json(:include => :species)
    end

    def show
        pokemon = Pokemon.find(params[:id])

        render json: pokemon.to_json(:include => [:moves, :abilities, :types, :species, :nature])
    end

    def create
        pokemon = Pokemon.create(pokemon_params)
        pokemon.save

        render json: pokemon.to_json(:include => [:species, :types, :user, :moves, :ability, :nature])
    end

    def update
        pokemon = Pokemon.find(params[:id])
        pokemon.update(pokemon_params)

        render json: pokemon.to_json(:include => [:species, :types, :user, :moves, :ability, :nature])
    end

    def destroy
        pokemon = Pokemon.find(params[:id])
        pokemon.destroy

    end

    private
    
    def pokemon_params
        params.permit(:name, :user_id, :species_id, :ability_id, :nature_id)
    end
end
