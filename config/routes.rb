Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :blog_posts do
    resource :header_image, only: [:destroy], module: :blog_posts
  end

  delete '/tag/:id', to: 'tags#destroy', as: :delete_tag
  put '/tag/:id', to: 'tags#update', as: :update_tag
  resources :tags, only: [:index, :destroy, :show, :update]

  root "blog_posts#index"
end
