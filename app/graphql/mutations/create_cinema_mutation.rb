class Mutations::CreateCinemaMutation < Mutations::BaseMutation
    argument(:name, String, required: true)
    argument(:location, String, required: true)
    argument(:seats, Integer, required: true)

    field(:result, Types::CinemaType, null: true)

    def resolve(
        name:,
        location:,
        seats:
    )
        cinema = Cinema.new(
            name: name,
            location: location,
            seats: seats
        )
        messages = []
        if cinema.save()
            messages << Utils.generate_message(
                "Successful cinema registration",
                "Your new cinema has been added to the database!",
                "positive"
            )
        else
            messages << Utils.generate_message(
                "Failed cinema registration",
                cinema.errors.full_messages,
                "negative",
            )
        end
        return {
            result: cinema.valid? ? cinema : nil,
            messages: messages
        }
    end
end