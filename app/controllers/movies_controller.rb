class MoviesController < ApplicationController

  def index
    @movies = Movie.order(average_rating: :desc)
    @movies.then(&paginate)

  end

  def new_import; end

  def perform_import
    movies_csv = params[:movies_csv]
    reviews_csv = params[:reviews_csv]

    if movies_csv.present? && reviews_csv.present?
      Services::ImportData.import_data(movies_csv.path, reviews_csv.path)
      flash[:notice] = 'CSV import completed successfully.'
    else
      flash[:error] = 'Please select both movies and reviews CSV files to import.'
    end

    redirect_to root_path
  end
end
