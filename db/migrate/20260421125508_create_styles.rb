class CreateStyles < ActiveRecord::Migration[8.1]
  def change
    create_table :styles do |t|
      t.string :style_number
      t.string :description
      t.references :buyer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
