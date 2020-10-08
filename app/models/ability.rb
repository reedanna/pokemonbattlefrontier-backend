class Ability < ApplicationRecord
    has_many :species_abilities
    has_many :species, through: :species_abilities
    has_many :pokemons
end
