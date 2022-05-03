module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field(:users, resolver: Resolvers::UsersResolver)
    field(:cinemas, resolver: Resolvers::CinemasResolver)
    field(:movies, resolver: Resolvers::MoviesResolver)
    field(:timeslots, resolver: Resolvers::TimeslotsResolver)
    field(:showings, resolver: Resolvers::ShowingsResolver)
    field(:bookings, resolver: Resolvers::BookingsResolver)
  end
end
