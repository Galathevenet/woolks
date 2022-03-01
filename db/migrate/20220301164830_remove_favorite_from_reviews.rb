class RemoveFavoriteFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :favorite
  end
end
