class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.bigint :origin_id
      t.bigint :target_id
      t.string :title
      t.text :notes
      t.integer :position, default: 0, null: false
      t.timestamps
    end

    add_index :links, %i[origin_id target_id], unique: true
  end
end
