class Resolvers::TimeslotsResolver < Resolvers::BaseResolver
    class TimeslotOutputType < OutputType
        field(:result, [Types::TimeslotType], null: false)
    end
    
    type(TimeslotOutputType, null: false)

    def resolve(filter: nil, order: nil, page: nil)
        return self.process(Timeslot.all, filter, order, page)
    end
end