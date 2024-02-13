class CreateActorsMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :actors_movies do |t|
      t.references :actor, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
    add_index :actors_movies, [:actor_id, :movie_id], unique: true
  end
end
