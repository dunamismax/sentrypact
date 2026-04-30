Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "pages#home"

  get "overview", to: "pages#overview", as: :overview
  get "pacts",    to: "pages#pacts",    as: :pacts
  get "privacy",  to: "pages#privacy",  as: :privacy
  get "safety",   to: "pages#safety",   as: :safety
  get "pricing",  to: "pages#pricing",  as: :pricing
  get "faq",      to: "pages#faq",      as: :faq
  get "support",  to: "pages#support",  as: :support
end
