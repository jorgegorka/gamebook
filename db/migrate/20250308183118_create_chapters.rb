class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.references :book, null: false, foreign_key: true
      t.string :title
      t.text :summary
      t.integer :position, null: false, default: 0
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :chapters, %i[book_id position], unique: true
  end
end
