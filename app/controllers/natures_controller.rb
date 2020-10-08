class NaturesController < ApplicationController

    def index
        natures = Nature.all

        render json: natures.to_json
    end

    def show
        nature = Nature.find(params[:id])

        render json: nature.to_json
    end
end
