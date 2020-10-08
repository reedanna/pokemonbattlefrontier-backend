class CreateSpecies < ActiveRecord::Migration[6.0]
  def change
    create_table :species do |t|
      t.string :name
      t.integer :HP
      t.integer :attack
      t.integer :special_attack
      t.integer :defense
      t.integer :special_defense
      t.integer :speed
      t.string :sprite_url
      t.string :icon_url

      t.timestamps
    end
  end
end
