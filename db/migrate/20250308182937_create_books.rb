class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :summary
      t.text :remarks
      t.integer :status, default: 0, null: false
      t.integer :chapters_count, default: 0, null: false

      t.timestamps
    end
  end
end
