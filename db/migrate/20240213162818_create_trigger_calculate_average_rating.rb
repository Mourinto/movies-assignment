class CreateTriggerCalculateAverageRating < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION calculate_average_rating()
      RETURNS TRIGGER AS $$
      BEGIN
        IF TG_OP = 'INSERT' THEN
          UPDATE movies
          SET average_rating = (
            (movies.average_rating * movies.review_count + NEW.stars) / (movies.review_count + 1)
          ),
          review_count = movies.review_count + 1
          WHERE movies.id = NEW.movie_id;
        END IF;
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER calculate_average_rating_trigger
      AFTER INSERT ON reviews
      FOR EACH ROW
      EXECUTE FUNCTION calculate_average_rating();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS calculate_average_rating_trigger ON reviews;
      DROP FUNCTION IF EXISTS calculate_average_rating();
    SQL
  end
end
