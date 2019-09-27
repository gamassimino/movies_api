class Api::V1::MoviesController < ApplicationController
  include RomanNumerals
  before_action :find_movie, except: [:index, :create, :build_cast,
                                      :full_name_list]

  def index
    @movies = Movie.all.map do |movie|
     {
      id: movie.id, title: movie.title,
      release_year: RomanNumerals.to_roman(Movie.first.release_year.try(:year))
     }
    end
    render json: @movies, status: :ok
  end

  def show
    movie = Movie.find params[:id]
    @movie = {
      title: movie.title, id: movie.id,
      release_year: RomanNumerals.to_roman(Movie.first.release_year.try(:year)),
      actors: full_name_list(actors.includes(:person)),
      directors: full_name_list(directors.includes(:person)),
      producers: full_name_list(producers.includes(:person))
    }
    render json: @movie, status: :ok
  end

  def create
    Movie.transaction do
      @movie = Movie.new movie_params
      if @movie.save
        build_cast(@movie.id, cast_params)
        render json: @movie, status: :ok
      else
        render json: @movie.errors.full_message, status: :ok
      end
    end
  end

  def update
    Movie.transaction do
      if @movie.update movie_params
        build_cast(@movie.id, cast_params)
        render json: @movie, status: :ok
      else
        render json: @movie.errors.full_message, status: :ok
      end
    end
  end

  def build_cast(movie_id, movie_params)
    actor_ids    = cast_params[:actor_ids]
    director_ids = cast_params[:director_ids]
    producer_ids = cast_params[:producer_ids]

    actor_ids.to_a.each do |actor_id|
      Role.find_or_create_by(movie_id: movie_id, person_id: actor_id,
                              role: :actor)
    end

    director_ids.to_a.each do |director_id|
      Role.find_or_create_by(movie_id: movie_id, person_id: director_id,
                              role: :director)
    end

    producer_ids.to_a.each do |producer_id|
      Role.find_or_create_by(movie_id: movie_id, person_id: producer_id,
                              role: :producer)
    end
  end

  def destroy
    Movie.transaction do
      @movie.roles.destroy_all!
      if @movie.destroy
        render json: 'movie deleted', status: :ok
      else
        render json: @movie.errors.full_message, status: :ok
      end
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

  private

  def find_movie
    @movie = Movie.find params[:id]
  end

  def full_name_list(people)
    people.map{ |p| "#{p.person.last_name} #{p.person.first_name}" }.join(' - ')
  end

  def movie_params
    params.permit(:title, :release_year)
  end

  def cast_params
    params.permit(actor_ids: [], director_ids: [], producer_ids: [])
  end
end
