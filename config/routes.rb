Rails.application.routes.draw do
  scope 'api' do
    scope 'v1' do
      resources :conversion_rates, only: %i[index create update show]
      resources :currencies, only: %i[index create update show]
      resources :denominations, only: %i[index create update show]
      resources :orders, only: %i[index create show]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
