# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'poke-api-v2'

#get types from API
for i in 1..18
    type = PokeApi.get(type: i)
    newType = Type.create(name: type.name, 
        strong_against: [], 
        weak_against: [], 
        no_effect_against: [], 
        resists: [], 
        weak_to: [], 
        immune_to: [])
    
    for j in 1..type.damage_relations.half_damage_from.length
        newType["resists"].push(type.damage_relations.half_damage_from[j - 1].name)
    end

    for j in 1..type.damage_relations.double_damage_from.length
        newType["weak_to"].push(type.damage_relations.double_damage_from[j - 1].name)
    end

    for j in 1..type.damage_relations.no_damage_from.length
        newType["immune_to"].push(type.damage_relations.no_damage_from[j - 1].name)
    end

    for j in 1..type.damage_relations.double_damage_to.length
        newType["strong_against"].push(type.damage_relations.double_damage_to[j - 1].name)
    end

    for j in 1..type.damage_relations.half_damage_to.length
        newType["weak_against"].push(type.damage_relations.half_damage_to[j - 1].name)
    end

    for j in 1..type.damage_relations.no_damage_to.length
        newType["no_effect_against"].push(type.damage_relations.no_damage_to[j - 1].name)
    end

    newType.save
end

#get natures from API
for i in 1..25
    nature = PokeApi.get(nature: i)
    newNature = Nature.create(name: nature.name, 
        stat_lowered: "none", 
        stat_raised: "none")
    
    if (nature.increased_stat.class == String)
        newNature.stat_lowered = nature.decreased_stat.name
        newNature.stat_raised = nature.increased_stat.name
    end

end

#get abilities from API
for i in 1..233
    ability = PokeApi.get(ability: i)
    newAbility = Ability.create(name: ability.name, 
        effect: ability.effect_entries.last.effect)
end

#get moves from API
for i in 1..7
    move = PokeApi.get(move: i)
    newMove = Move.create(name: move.name, 
        category: move.damage_class.name, 
        bp: 0, 
        other_effects: move.effect_entries.last.effect, 
        type: Type.find_by(name: move.type.name))

    if (move.power.class == Integer)
        newMove.bp = move.power
    end
end

#get species from API
for i in 1..807
    species = PokeApi.get(pokemon: i)
    newSpecies = Species.create(name: species.name.capitalize(), 
        HP: species.stats[0].base_stat, 
        attack: species.stats[1].base_stat, 
        defense: species.stats[2].base_stat, 
        special_attack: species.stats[3].base_stat,
        special_defense: species.stats[4].base_stat,
        speed: species.stats[5].base_stat,
        sprite_url: species.sprites.front_default)

    #add types to species
    for j in 1..species.types.length
        type = Type.find_by(name: species.types[j-1].type.name)
        SpeciesType.create(species_id: species.id, type_id: type.id)
    end

    #add abilities to species
    for j in 1..species.abilities.length
        ability = Ability.find_by(name: species.abilities[j-1].ability.name)
        SpeciesAbility.create(species_id: species.id, ability_id: ability.id)
    end

    #add moves to species
    for j in 1..species.moves.length
        move = Move.find_by(name: species.moves[j-1].move.name)
        SpeciesMove.create(species_id: species.id, move_id: move.id)
    end

end
