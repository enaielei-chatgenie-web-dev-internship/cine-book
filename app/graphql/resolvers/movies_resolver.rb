class Resolvers::MoviesResolver < Resolvers::BaseResolver
    class MovieOutputType < OutputType
        field(:result, [Types::MovieType], null: false)
    end
    
    type(MovieOutputType, null: false)

    def resolve(filter: nil, order: nil, page: nil)
        return self.process(Movie.all, filter, order, page)
    end
end