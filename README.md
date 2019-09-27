# Movies App - Rails challange

App running with the following features:

* Ruby version 2.5.1

* Rails 5.2.3


## Hosting on Heroku

* https://movies-api-rails.herokuapp.com

## Description

The idea is create a simple rails API that only allow you manage to models

* Movie
* Person

and currently is conected with an existing rails app hosting on:
* heroku: https://movies-app-rails.herokuapp.com
* github: https://github.com/gamassimino/movies-app

## EndPoints

### movies restfull methods
* https://movies-api-rails.herokuapp.com/api/v1/movies `GET`
* https://movies-api-rails.herokuapp.com/api/v1/movies/:id `GET`
* https://movies-api-rails.herokuapp.com/api/v1/movies/:id `PUT`
* https://movies-api-rails.herokuapp.com/api/v1/movies/:id `DELETE`
* https://movies-api-rails.herokuapp.com/api/v1/movies `POST`

### get all movies' actors
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/movies/actors `GET`

### get all movies' directors
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/movies/directors `GET`

### get all movies' producers
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/movies/producers `GET`

### people restfull methods
* https://movies-api-rails.herokuapp.com/api/v1/people `GET`
* https://movies-api-rails.herokuapp.com/api/v1/people/:id `GET`
* https://movies-api-rails.herokuapp.com/api/v1/people/:id `PUT`
* https://movies-api-rails.herokuapp.com/api/v1/people/:id `DELETE`
* https://movies-api-rails.herokuapp.com/api/v1/people `POST`

### get all movies performed by an actor
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/people/movies_as_actor `GET`

### get all movies directed by a director
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/people/movies_as_director `GET`

### get all movies produced by a productor
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/people/movies_as_producer `GET`

### get all actors
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/people/actors `GET`

### get all directors
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/people/directors `GET`

### get all productors
* https://movies-api-rails.herokuapp.com/api/v1/api/v1/people/producers `GET`
