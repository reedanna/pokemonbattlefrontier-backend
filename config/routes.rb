Rails.application.routes.draw do
  resources :pokemon_moves
  resources :species_moves
  resources :species_types
  resources :species_abilities
  resources :users
  resources :natures
  resources :pokemons
  resources :moves
  resources :abilities
  resources :types
  resources :species
  post '/login', to: 'auth#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
