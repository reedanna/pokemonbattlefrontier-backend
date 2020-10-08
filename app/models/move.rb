class Move < ApplicationRecord
    has_many :species_moves
    has_many :pokemon_moves
    has_many :species, through: :species_moves
    has_many :pokemons, through: :pokemons_moves
    belongs_to :type
end
