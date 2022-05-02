# frozen_string_literal: true

module Types
  class BookingType < Types::BaseObject
    field :id, ID, null: false
    field :showing_id, Integer, null: false
    field :user_id, Integer
    field :seat, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
