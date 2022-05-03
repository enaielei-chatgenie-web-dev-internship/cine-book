# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String
    field :full_name, String
    field :mobile_number, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :password_digest, String
    field :activation_digest, String
    field :activated, Boolean
    field :session_digest, String
    field :admin, Boolean

    field :bookings, [BookingType], null: false
  end
end
