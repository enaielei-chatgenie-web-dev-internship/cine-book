module Types
  class MutationType < Types::BaseObject
    # User
    field(:create_user, mutation: Mutations::CreateUserMutation)

    # Cinema
    field(:create_cinema, mutation: Mutations::CreateCinemaMutation)
    field(:destroy_cinema, mutation: Mutations::DestroyCinemaMutation)

    # Movie
    field(:create_movie, mutation: Mutations::CreateMovieMutation)
    field(:destroy_movie, mutation: Mutations::DestroyMovieMutation)

    # Timeslot
    field(:create_timeslot, mutation: Mutations::CreateTimeslotMutation)
    field(:destroy_timeslot, mutation: Mutations::DestroyTimeslotMutation)

    # Showing
    field(:create_showing, mutation: Mutations::CreateShowingMutation)
    field(:destroy_showing, mutation: Mutations::DestroyShowingMutation)

    # Booking
    field(:create_booking, mutation: Mutations::CreateBookingMutation)
    field(:destroy_booking, mutation: Mutations::DestroyBookingMutation)
  end
end
