class CreateQuantities < ActiveRecord::Migration[7.2]
  def change
    create_table :quantities do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :ingredient_name
      t.decimal :amount

      t.timestamps
    end
  end
end
