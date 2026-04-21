class CreateSamples < ActiveRecord::Migration[8.1]
  def change
    create_table :samples do |t|
      t.references :style, null: false, foreign_key: true
      t.string :sample_type
      t.date :date_sent
      t.string :status
      t.text :buyer_comments

      t.timestamps
    end
  end
end
