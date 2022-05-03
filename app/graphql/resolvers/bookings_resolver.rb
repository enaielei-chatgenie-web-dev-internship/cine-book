class Resolvers::BookingsResolver < Resolvers::BaseResolver
    class BookingOutputType < OutputType
        field(:result, [Types::BookingType], null: false)
    end
    
    type(BookingOutputType, null: false)

    def resolve(filter: nil, order: nil, page: nil)
        return self.process(Booking.all, filter, order, page)
    end
end