class Api::V1::PeopleController < ApplicationController
  before_action :find_person, except: [:index, :create]

  def index
    @people = Person.all.to_json
    render json: @people, status: :ok
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  def movies_as_actor
    @person.roles.actors.map { |role| role.movie}
  end

  def movies_as_director
    @person.roles.directors.map { |role| role.movie}
  end

  def movies_as_producer
    @person.roles.producers.map { |role| role.movie}
  end

  def find_person
    @person = Person.find params[:id]
  end
end
