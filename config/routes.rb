Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies do
        get :actors, on: :member
        get :directors, on: :member
        get :producers, on: :member
      end

      resources :people do
        get :movies_as_actor, on: :member
        get :movies_as_director, on: :member
        get :movies_as_producer, on: :member
      end
    end
  end
end
