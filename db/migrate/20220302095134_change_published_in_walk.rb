class ChangePublishedInWalk < ActiveRecord::Migration[6.1]
  def change
    change_column_default :walks, :published, from: true, to: false
  end
end
