class ActorsController < ApplicationController
  def index
    @actors = Actor.all
  end

  def search
    query = params[:query]
    @actors = Actor.where("name ILIKE ?", "%#{query}%")
  end

  def show
    @actor = Actor.find(params[:id])
    @movies = @actor.movies
  end
end
