class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, comment: "カテゴリー名称"

      t.timestamps

      t.index :name, unique: true
    end
  end
end
