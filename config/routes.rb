Rails.application.routes.draw do
  devise_for :users
  resources :products do
    post :add_to_favorite, on: :member
    delete :delete_from_favorite, on: :member
    get :sort_by, on: :collection
  end

  root to: 'products#index'
end
