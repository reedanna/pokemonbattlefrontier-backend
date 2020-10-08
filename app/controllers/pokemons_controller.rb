class PokemonsController < ApplicationController
    def index
        pokemons = Pokemon.all

        render json: pokemons.to_json(:include => [:moves, :abilities, :types, :species, :nature])
    end

    def show
        pokemon = Pokemon.find(params[:id])

        render json: pokemon.to_json(:include => [:moves, :abilities, :types, :species, :nature])
    end
end
