class Resolvers::CinemasResolver < Resolvers::BaseResolver
    class CinemaOutputType < OutputType
        field(:result, [Types::CinemaType], null: false)
    end
    
    type(CinemaOutputType, null: false)

    def resolve(filter: nil, order: nil, page: nil)
        return self.process(Cinema.all, filter, order, page)
    end
end