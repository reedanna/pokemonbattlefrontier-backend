class AbilitiesController < ApplicationController

    def index
        abilities = Ability.all

        render json: abilities.to_json
    end

    def show
        ability = Ability.find(params[:id])

        render json: ability.to_json
    end


end
