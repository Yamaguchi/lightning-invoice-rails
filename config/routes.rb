# frozen_string_literal: true

Rails.application.routes.draw do
  resources :encodes, only: [:index, :new, :create] do
    get 'routing_info', on: :collection
    delete 'routings', on: :collection
  end
  resources :decodes, only: [:index, :new, :create]
  root 'encodes#new'
end
