class CreateTags < ActiveRecord::Migration[7.2]
  def change
    create_table :tags do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :tags, :name, unique: true  # 重複しないようにするためのインデックス
  end
end
