Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root("application#index")
  get("/api", to: "application#api", as: :api)

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
  get("/cinemas", to: "cinemas#new", as: :new_cinema)
  post("/cinemas", to: "cinemas#create", as: :create_cinema)
  get("/cinemas/:id", to: "cinemas#show", as: :show_cinema)
  delete("/cinemas/:id", to: "cinemas#destroy", as: :destroy_cinema)

  # Movies
  get("/movies", to: "movies#new", as: :new_movie)
  post("/movies", to: "movies#create", as: :create_movie)
  get("/movies/:id", to: "movies#show", as: :show_movie)
  delete("/movies/:id", to: "movies#destroy", as: :destroy_movie)

  # Timeslots
  get("/timeslots", to: "timeslots#new", as: :new_timeslot)
  post("/timeslots", to: "timeslots#create", as: :create_timeslot)
  get("/timeslots/:id", to: "timeslots#show", as: :show_timeslot)
  delete("/timeslots/:id", to: "timeslots#destroy", as: :destroy_timeslot)

  # Showings
  get("/showings", to: "showings#new", as: :new_showing)
  post("/showings", to: "showings#create", as: :create_showing)
  get("/showings/:id", to: "showings#show", as: :show_showing)
  delete("/showing/:id", to: "showings#destroy", as: :destroy_showing)

  # Bookings
  get("/bookings", to: "bookings#new", as: :new_booking)
  post("/bookings", to: "bookings#create", as: :create_booking)
  get("/bookings/:id", to: "bookings#show", as: :show_booking)
  delete("/booking/:id", to: "bookings#destroy", as: :destroy_booking)
end
