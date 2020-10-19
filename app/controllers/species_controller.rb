class SpeciesController < ApplicationController
    def index
        species = Species.all.order(:id)

        render json: species.to_json(:include => [:types, :abilities])
    end

    def show
        species = Species.find(params[:id])

        render json: species.to_json(:include => [{:moves => {:include => :type}}, :abilities, :types])
    end
end
