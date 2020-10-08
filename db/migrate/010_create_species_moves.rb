class CreateSpeciesMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :species_moves do |t|
      t.references :move, null: false, foreign_key: true
      t.references :species, null: false, foreign_key: true

      t.timestamps
    end
  end
end
