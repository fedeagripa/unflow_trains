Rails.application.routes.draw do
  root "home#index"

  post "/question", to: "home#question"
end
