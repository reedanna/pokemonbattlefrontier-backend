# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'poke-api-v2'

#create test user
User.create(name: "test", password_digest: "1234")

#get types from API
for i in 1..18
    type = PokeApi.get(type: i)
    newType = Type.create(name: type.name.capitalize(), 
        strong_against: [], 
        weak_against: [], 
        no_effect_against: [], 
        resists: [], 
        weak_to: [], 
        immune_to: [])
    
    for j in 1..type.damage_relations.half_damage_from.length
        newType["resists"].push(type.damage_relations.half_damage_from[j - 1].name.capitalize())
    end

    for j in 1..type.damage_relations.double_damage_from.length
        newType["weak_to"].push(type.damage_relations.double_damage_from[j - 1].name.capitalize())
    end

    for j in 1..type.damage_relations.no_damage_from.length
        newType["immune_to"].push(type.damage_relations.no_damage_from[j - 1].name.capitalize())
    end

    for j in 1..type.damage_relations.double_damage_to.length
        newType["strong_against"].push(type.damage_relations.double_damage_to[j - 1].name.capitalize())
    end

    for j in 1..type.damage_relations.half_damage_to.length
        newType["weak_against"].push(type.damage_relations.half_damage_to[j - 1].name.capitalize())
    end

    for j in 1..type.damage_relations.no_damage_to.length
        newType["no_effect_against"].push(type.damage_relations.no_damage_to[j - 1].name.capitalize())
    end

    newType.save
end

#get natures from API
for i in 1..25
    nature = PokeApi.get(nature: i)
    newNature = Nature.create(name: nature.name.capitalize(), 
        stat_lowered: "none", 
        stat_raised: "none")
    
    if (nature.increased_stat)
        newNature.stat_lowered = nature.decreased_stat.name.split('-').join('_')
        newNature.stat_raised = nature.increased_stat.name.split('-').join('_')
    end

    newNature.save
end

#get abilities from API
for i in 1..233
    ability = PokeApi.get(ability: i)
    newAbility = Ability.create(name: ability.name.split('-').join(' ').capitalize(), 
        effect: ability.effect_entries.last.effect)

    if (newAbility.id == 145 || newAbility.id == 119 || newAbility.id == 103 || newAbility.id == 64 || newAbility.id == 65)
        newAbility.update(effect: ability.effect_entries.first.effect)
    end
end

#get moves from API
for i in 1..742
    move = PokeApi.get(move: i)
    newMove = Move.create(name: move.name.split('-').join(' ').capitalize(), 
        category: move.damage_class.name.capitalize(), 
        bp: move.power, 
        other_effects: move.effect_entries.last.effect.gsub('$effect_chance%', move.effect_chance), 
        type: Type.find_by(name: move.type.name.capitalize()))
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
        type = Type.find_by(name: species.types[j-1].type.name.capitalize())
        SpeciesType.create(species_id: species.id, type_id: type.id)
    end

    #add abilities to species
    for j in 1..species.abilities.length
        ability = Ability.find_by(name: species.abilities[j-1].ability.name.split('-').join(' ').capitalize())
        SpeciesAbility.create(species_id: species.id, ability_id: ability.id)
    end

    #add moves to species
    for j in 1..species.moves.length
        move = Move.find_by(name: species.moves[j-1].move.name.split('-').join(' ').capitalize())
        SpeciesMove.create(species_id: species.id, move_id: move.id)
    end

end
