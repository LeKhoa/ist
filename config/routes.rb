Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "reset", to: "transaction#reset"
  post "transfer", to: "transaction#transfer"
  get "get_amounts", to: "transaction#amounts"
end
