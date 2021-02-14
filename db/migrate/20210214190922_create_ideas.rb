class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.bigint :category_id, null: false
      t.text :body, null: false, comment: "アイデア本文"

      t.timestamps
    end
  end
end
