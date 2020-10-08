class Species < ApplicationRecord
    has_many :pokemons
    has_many :species_abilities
    has_many :abilities, through: :species_abilities
    has_many :species_types
    has_many :types, through: :species_types
    has_many :species_moves
    has_many :moves, through: :species_moves
end
