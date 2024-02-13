class Movie < ApplicationRecord
  has_many :actors_movies, dependent: :destroy
  has_many :actors, through: :actors_movies
  has_many :reviews, dependent: :destroy
end
