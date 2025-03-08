class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :summary
      t.text :remarks
      t.integer :status

      t.timestamps
    end
  end
end
