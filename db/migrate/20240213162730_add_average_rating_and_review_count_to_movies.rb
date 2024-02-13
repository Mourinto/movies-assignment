class AddAverageRatingAndReviewCountToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :average_rating, :float, default: 0.0
    add_column :movies, :review_count, :integer, default: 0
  end
end
