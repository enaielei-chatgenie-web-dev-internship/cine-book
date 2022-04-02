Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root("application#index")

  # Sign Up
  get("/auth", to: "users#new")
  get("/auth/sign-up", to: "users#new", as: :new_user)
  post("/auth/sign-up", to: "users#create", as: :create_user)

  # Sign In
  get("/auth/sign-in", to: "sessions#new", as: :new_session)
  post("/auth/sign-in", to: "sessions#create", as: :create_session)
  delete("/auth/sign-out", to: "sessions#destroy", as: :destroy_session)

  # Password Reset
  get("/auth/password-reset", to: "password_resets#new", as: :new_password_reset)
  post("/auth/password-reset", to: "password_resets#create", as: :create_password_reset)

  # Cinemas
  get("/new-cinema", to: "cinemas#new", as: :new_cinema)
  post("/new-cinema", to: "cinemas#create", as: :create_cinema)

  # Movies
  get("/new-movie", to: "movies#new", as: :new_movie)
  post("/new-movie", to: "movies#create", as: :create_movie)

  # Timeslots
  get("/new-timeslot", to: "timeslots#new", as: :new_timeslot)
  post("/new-timeslot", to: "timeslots#create", as: :create_timeslot)
end
