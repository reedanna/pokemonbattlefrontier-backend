class SpeciesController < ApplicationController
    def index
        species = Species.all

        render json: species.to_json(:include => [:moves, :abilities, :types])
    end

    def show
        species = Species.find(params[:id])

        render json: species.to_json(:include => [:moves, :abilities, :types])
    end
end
