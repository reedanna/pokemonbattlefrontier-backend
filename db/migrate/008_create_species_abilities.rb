class CreateSpeciesAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :species_abilities do |t|
      t.references :ability, null: false, foreign_key: true
      t.references :species, null: false, foreign_key: true

      t.timestamps
    end
  end
end
