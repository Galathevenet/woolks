class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :walk, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :comment
      t.integer :rating
      t.boolean :favorite

      t.timestamps
    end
  end
end
