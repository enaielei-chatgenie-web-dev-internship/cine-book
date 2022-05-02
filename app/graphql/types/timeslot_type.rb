# frozen_string_literal: true

module Types
  class TimeslotType < Types::BaseObject
    field :id, ID, null: false
    field :time, Types::TimeType
    field :label, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
