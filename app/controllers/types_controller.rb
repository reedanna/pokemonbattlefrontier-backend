class TypesController < ApplicationController
    def index
        types = Type.all

        render json: types.to_json
    end

    def show
        type = Type.find(params[:id])

        render json: type.to_json
    end
end
