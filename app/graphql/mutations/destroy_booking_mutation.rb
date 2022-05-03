class Mutations::DestroyBookingMutation < Mutations::DestroyMutation
    field(:result, [Types::BookingType], null: false)

    def resolve(
        condition:,
        values: nil
    )
        return self.destroy(Booking, condition, *values)
    end
end