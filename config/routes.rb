# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'

  resources :posts do
    resources :comments
    member do
      delete :delete_image_attachment
     end
  end

end
