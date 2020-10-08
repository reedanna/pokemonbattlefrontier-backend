class MovesController < ApplicationController

    def index
        moves = Move.all

        render json: moves.to_json(:include => :type)
    end

    def show
        move = Move.find(params[:id])

        render json: move.to_json(:include => :type)
    end

end
