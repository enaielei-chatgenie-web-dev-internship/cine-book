class Resolvers::ShowingsResolver < Resolvers::BaseResolver
    class ShowingOutputType < OutputType
        field(:result, [Types::ShowingType], null: false)
    end
    
    type(ShowingOutputType, null: false)

    def resolve(filter: nil, order: nil, page: nil)
        return self.process(Showing.all, filter, order, page)
    end
end