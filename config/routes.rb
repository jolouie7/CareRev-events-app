Rails.application.routes.draw do
  post '/events', to: 'event#create'
  get '/events/stats', to: 'event#todays_stats'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
