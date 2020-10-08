class CreateTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :types do |t|
      t.string :name
      t.string :strong_against, array: true
      t.string :weak_against, array: true
      t.string :no_effect_against, array: true
      t.string :resists, array: true
      t.string :weak_to, array: true
      t.string :immune_to, array: true

      t.timestamps
    end
  end
end
