# frozen_string_literal: true

Rails.application.routes.draw do
  resources :encodes, only: [:index, :new, :create]
  resources :decodes, only: [:index, :new, :create]
  root 'encodes#new'
end
