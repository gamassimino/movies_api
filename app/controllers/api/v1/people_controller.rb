class Api::V1::PeopleController < ApplicationController
  before_action :find_person, except: [:index, :create]

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
      first_name: person['first_name'],
      last_name: person['last_name'],
      aliases: person['aliases'],
      movies_as_actor: movies_as_actor.pluck(:title).join(', '),
      movies_as_director: movies_as_director.pluck(:title).join(', '),
      movies_as_producer: movies_as_producer.pluck(:title).join(', ')
    }
    render json: @person, status: :ok
  end

  def create
    @person = Person.new person_params
    if @person.save
      render json: @person, status: :ok
    else
      render json: @person.errors.full_message, status: :ok
    end
  end

  def update
  end

  def destroy
    person = Person.find params[:id]
    if person.destroy
      render json: 'person deleted', status: :ok
    else
      render json: person.errors.full_message, status: :ok
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

  def find_person
    @person = Person.find params[:id]
  end

  private

  def person_params
    params.permit(:first_name, :last_name, :aliases)
  end
end
