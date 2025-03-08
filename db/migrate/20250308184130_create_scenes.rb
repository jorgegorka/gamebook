class CreateScenes < ActiveRecord::Migration[8.0]
  def change
    create_table :scenes do |t|
      t.references :chapter, null: false, foreign_key: true
      t.text :body
      t.text :notes
      t.integer :status
      t.integer :category

      t.timestamps
    end
  end
end
