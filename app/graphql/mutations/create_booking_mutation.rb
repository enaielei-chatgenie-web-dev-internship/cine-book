class Mutations::CreateBookingMutation < Mutations::BaseMutation
    argument(:showing_id, Integer, required: true)
    argument(:user_id, Integer, required: true)
    argument(:seat, Integer, required: true)

    field(:result, Types::BookingType, null: true)

    def resolve(
        showing_id:,
        user_id:,
        seat:
    )
        booking = Booking.new(
            showing_id: showing_id,
            user_id: user_id,
            seat: seat
        )
        messages = []
        if booking.save()
            messages << Utils.generate_message(
                "Successful booking registration",
                "Your new booking has been added to the database!",
                "positive"
            )
        else
            messages << Utils.generate_message(
                "Failed booking registration",
                booking.errors.full_messages,
                "negative",
            )
        end
        return {
            result: booking.valid? ? booking : nil,
            messages: messages
        }
    end
end