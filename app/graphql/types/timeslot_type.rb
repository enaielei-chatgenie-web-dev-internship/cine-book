# frozen_string_literal: true

module Types
  class TimeslotType < Types::BaseObject
    field :id, ID, null: false
    field :time, GraphQL::Types::ISO8601DateTime
    field :label, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :pretty_time, String
    field :showings, [TimeslotType], null: false
  end
end
