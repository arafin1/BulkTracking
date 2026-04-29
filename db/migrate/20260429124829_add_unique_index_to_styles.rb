class AddUniqueIndexToStyles < ActiveRecord::Migration[8.1]
 def change
    add_index :styles, :style_number, unique: true
  end
end
