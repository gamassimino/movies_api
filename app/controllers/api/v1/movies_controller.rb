class Api::V1::MoviesController < ApplicationController
  before_action :find_movie, except: [:index, :create]

  def index
    @movies = Movie.all.to_json
    render json: @movies, status: :ok
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  def actors
    @movie.roles.actors
  end

  def directors
    @movie.roles.directors
  end

  def producers
    @movie.roles.producers
  end

  def find_movie
    @movie = Movie.find params[:id]
  end
end
