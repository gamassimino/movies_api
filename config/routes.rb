Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :movies do
        get :index, on: :collection
        get :actors, on: :member
        get :directors, on: :member
        get :producers, on: :member
      end

      resource :people do
        get :index, on: :collection
        get :movies_as_actor, on: :member
        get :movies_as_director, on: :member
        get :movies_as_producer, on: :member
      end
    end
  end
end
