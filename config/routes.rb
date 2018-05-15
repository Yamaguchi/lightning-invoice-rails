# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get  '/*id', to: 'pages#show', as: :page, format: false, constraints: HighVoltage::Constraints::RootRoute
  root 'pages#home'
end
