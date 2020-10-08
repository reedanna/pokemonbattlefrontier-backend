class CreateSpeciesTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :species_types do |t|
      t.references :type, null: false, foreign_key: true
      t.references :species, null: false, foreign_key: true

      t.timestamps
    end
  end
end
