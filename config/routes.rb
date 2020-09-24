# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :shipments, only: [] do
      resource :postage_label, only: :show
    end
  end
end
