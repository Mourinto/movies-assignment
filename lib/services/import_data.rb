require 'csv'

module Services
  class ImportData
    def self.import_data(movies_csv_path, reviews_csv_path)
      batch_size = 50
      movie_records = []
      actor_records = []
      review_records = []
      actors_movies_records = []

      CSV.foreach(movies_csv_path, headers: true) do |row|
        movie_data = {
          title: row['Movie'],
          description: row['Description'],
          year: row['Year'],
          director: row['Director'],
          filming_location: row['Filming location'],
          country: row['Country']
        }

        actor_data = {
          name: row['Actor']
        }

        movie_records << movie_data
        actor_records << actor_data

        if movie_records.length >= batch_size
          insert_movies_and_actors(movie_records, actor_records, actors_movies_records)
        end
      end

      insert_movies_and_actors(movie_records, actor_records, actors_movies_records)


      CSV.foreach(reviews_csv_path, headers: true) do |row|
        review_data = {
          movie_id: Movie.find_by(title: row['Movie']).id,
          user: row['User'],
          stars: row['Stars'],
          review: row['Review']
        }

        review_records << review_data

        if review_records.length >= batch_size
          Review.insert_all(review_records)
          review_records = []
        end
      end

      Review.insert_all(review_records)
    end

    def self.insert_movies_and_actors(movie_records, actor_records, actors_movies_records)
      Movie.transaction do
        movies = Movie.insert_all(movie_records)
        actors = Actor.insert_all(actor_records)

        actors.each do |actor|
          movie_title = actor_records.find { |record| record['name'] == actor['name'] }['title']
          movie_id = movies.find { |movie| movie['title'] == movie_title }['id']
          actor_id = actor['id']
          actors_movies_records << { movie_id: movie_id, actor_id: actor_id }
        end

        ActorsMovie.insert_all(actors_movies_records)
      end
    end


  end
end


