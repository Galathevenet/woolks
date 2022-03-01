class CreateHotspotWalks < ActiveRecord::Migration[6.1]
  def change
    create_table :hotspot_walks do |t|
      t.references :hotspot, null: false, foreign_key: true
      t.references :walk, null: false, foreign_key: true

      t.timestamps
    end
  end
end
