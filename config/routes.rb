Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :studios
  resources :movies
  post '/movies/:movie_id/movie-actors', to: 'movie_actors#create'
end
