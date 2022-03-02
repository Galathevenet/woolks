class ChangeDurationInWalks < ActiveRecord::Migration[6.1]
  def change
    remove_column :walks, :duration
    add_column :walks, :duration, :integer
  end
end
