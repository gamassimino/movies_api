class Api::V1::PeopleController < ApplicationController
  before_action :find_person, only: [:show, :update, :destroy, :movies_as_actor,
                                      :movies_as_director, :movies_as_producer]

  def index
    @persons = Person.all.map do |person|
     {
      id: person.id, first_name: person.first_name,
      last_name: person.last_name, aliases: person.aliases
     }
    end
    render json: @persons, status: :ok
  end

  def show
    person = Person.find params[:id]
    @person = {
      first_name: person['first_name'], last_name: person['last_name'],
      aliases: person['aliases'], id: person['id'],
      movies_as_actor: movies_as_actor.pluck(:title).join(', '),
      movies_as_director: movies_as_director.pluck(:title).join(', '),
      movies_as_producer: movies_as_producer.pluck(:title).join(', ')
    }
    render json: @person, status: :ok
  end

  def create
    Person.transaction do
      @person = Person.new person_params
      build_cast(@person.id, cast_params)
      if @person.save
        render json: @person, status: :ok
      else
        render json: @person.errors.full_message, status: :ok
      end
    end
  end

  def update
    Person.transaction do
      if @person.update person_params
        build_cast(@person.id, cast_params)
        render json: @person, status: :ok
      else
        render json: @person.errors.full_message, status: :ok
      end
    end
  end

  def build_cast(person_id, cast_params)
    movie_actor_ids    = cast_params[:movie_actor_ids]
    movie_director_ids = cast_params[:movie_director_ids]
    movie_producer_ids = cast_params[:movie_producer_ids]

    movie_actor_ids.to_a.each do |movie_id|
      Role.find_or_create_by(movie_id: movie_id, person_id: person_id,
                              role: :actor)
    end

    movie_director_ids.to_a.each do |movie_id|
      Role.find_or_create_by(movie_id: movie_id, person_id: person_id,
                              role: :director)
    end

    movie_producer_ids.to_a.each do |movie_id|
      Role.find_or_create_by(movie_id: movie_id, person_id: person_id,
                              role: :producer)
    end
  end

  def destroy
    Person.transaction do
      @person.roles.destroy_all!
      if @person.destroy!
        render json: "Person #{params[:id]} deleted", status: :ok
      else
        render json: @person.errors.full_message, status: :ok
      end
    end
  end

  def movies_as_actor
    @person.roles.actors.map { |role| role.movie }
  end

  def movies_as_director
    @person.roles.directors.map { |role| role.movie }
  end

  def movies_as_producer
    @person.roles.producers.map { |role| role.movie }
  end

  def actors
    actors = Role.actors.map { |r| [r.person.id, r.person.full_name] }
    render json: actors, status: :ok
  end

  def directors
    directors = Role.directors.map { |r| [r.person.id, r.person.full_name] }
    render json: directors, status: :ok
  end

  def producers
    producers = Role.producers.map { |r| [r.person.id, r.person.full_name] }
    render json: producers, status: :ok
  end

  private

  def find_person
    @person = Person.find params[:id]
  end

  def person_params
    params.permit(:first_name, :last_name, :aliases)
  end

  def cast_params
    params.permit(movie_actor_ids: [], movie_director_ids: [], movie_producer_ids: [])
  end
end
