class Pokemon < ApplicationRecord
    belongs_to :user
    belongs_to :nature
    belongs_to :ability
    belongs_to :species
    has_many :pokemon_moves
    has_many :moves, through: :pokemon_moves
    has_many :types, through: :species
end
