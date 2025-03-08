class CreateChapters < ActiveRecord::Migration[8.0]
  def change
    create_table :chapters do |t|
      t.references :book, null: false, foreign_key: true
      t.string :title
      t.text :summary
      t.integer :position

      t.timestamps
    end
  end
end
