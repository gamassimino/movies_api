class Api::V1::RolesController < ApplicationController
  def actors
    Role.actors
  end

  def directors
    Role.directors
  end

  def producers
    Role.producers
  end
end
