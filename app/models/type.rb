class Type < ApplicationRecord
    has_many :moves
    has_many :species_types
    has_many :species, through: :species_types
    has_many :pokemons, through: :species
end
