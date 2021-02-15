class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.references :category, null: false, foreign_key: true
      t.text :body, null: false, comment: "アイデア本文"

      t.timestamps
    end
  end
end
