class CreateHotspots < ActiveRecord::Migration[6.1]
  def change
    create_table :hotspots do |t|
      t.string :type
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
