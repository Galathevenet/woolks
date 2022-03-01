class CreateWaypoints < ActiveRecord::Migration[6.1]
  def change
    create_table :waypoints do |t|
      t.references :walk, null: false, foreign_key: true
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
