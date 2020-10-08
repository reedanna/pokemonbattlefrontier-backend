class CreateNatures < ActiveRecord::Migration[6.0]
  def change
    create_table :natures do |t|
      t.string :name
      t.string :stat_lowered
      t.string :stat_raised

      t.timestamps
    end
  end
end
