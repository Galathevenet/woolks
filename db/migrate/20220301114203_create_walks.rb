class CreateWalks < ActiveRecord::Migration[6.1]
  def change
    create_table :walks do |t|
      t.string :name
      t.string :description
      t.date :date
      t.time :duration
      t.float :length
      t.boolean :published
      t.float :start_point_latitude
      t.float :start_point_longitude
      t.float :end_point_latitude
      t.float :end_point_longitude
      t.references :user, null: false, foreign_key: true
      t.references :original_walk, index: true, foreign_key: { to_table: :walks }

      t.timestamps
    end
  end
end
