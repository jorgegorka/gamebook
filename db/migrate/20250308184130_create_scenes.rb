class CreateScenes < ActiveRecord::Migration[8.0]
  def change
    create_table :scenes do |t|
      t.references :chapter, null: false, foreign_key: true
      t.text :body
      t.text :notes
      t.integer :status, default: 0, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :scenes, %i[chapter_id position]
  end
end
