class ChangeTypeInHotspots < ActiveRecord::Migration[6.1]
  def change
    rename_column :hotspots, :type, :category
  end
end
