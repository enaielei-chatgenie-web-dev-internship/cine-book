# frozen_string_literal: true

module Types
  class ShowingType < Types::BaseObject
    field :id, ID, null: false
    field :cinema_id, Integer
    field :movie_id, Integer
    field :timeslot_id, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :cinema, CinemaType
    field :movie, MovieType
    field :timeslot, TimeslotType
    field :seats, Integer
    field :seats_taken, [Integer], null: false
    field :seats_free, [Integer], null: false
    field :bookings, [BookingType], null: false
  end
end
