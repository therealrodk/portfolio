Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :blog_posts do
    resource :header_image, only: [:destroy], module: :blog_posts
  end

  root "blog_posts#index"
end
