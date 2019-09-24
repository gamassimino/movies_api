class Api::V1::MoviesController < ApplicationController
  include RomanNumerals
  before_action :find_movie, except: [:index, :create]

  def index
    @movies = Movie.all.map do |movie|
     {
      id: movie.id, title: movie.title,
      release_year: RomanNumerals.to_roman(Movie.first.release_year.year)
     }
    end
    render json: @movies, status: :ok
  end

  def show
    movie = Movie.find params[:id]
    @movie = {
      title: movie.title,
      release_year: RomanNumerals.to_roman(Movie.first.release_year.year),
      actors: actors.joins(:person).pluck(:first_name).join(', '),
      directors: directors.joins(:person).pluck(:first_name).join(', '),
      producers: producers.joins(:person).pluck(:first_name).join(', ')
    }
    render json: @movie, status: :ok
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      render json: @movie, status: :ok
    else
      render json: @movie.errors.full_message, status: :ok
    end
  end

  def update
  end

  def destroy
    movie = Movie.find params[:id]
    if movie.destroy
      render json: 'movie deleted', status: :ok
    else
      render json: movie.errors.full_message, status: :ok
    end
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

  private

  def movie_params
    params.permit(:title, :release_year)
  end
end
