# frozen_string_literal: true

module Types
  class ShowingType < Types::BaseObject
    field :id, ID, null: false
    field :cinema_id, Integer
    field :movie_id, Integer
    field :timeslot_id, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
