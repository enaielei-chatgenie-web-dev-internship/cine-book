class Mutations::CreateShowingMutation < Mutations::BaseMutation
    argument(:cinema_id, Integer, required: true)
    argument(:movie_id, Integer, required: true)
    argument(:timeslot_id, Integer, required: true)

    field(:result, Types::ShowingType, null: true)

    def resolve(
        cinema_id:,
        movie_id:,
        timeslot_id:
    )
        showing = Showing.new(
            cinema_id: cinema_id,
            movie_id: movie_id,
            timeslot_id: timeslot_id
        )
        messages = []
        if showing.save()
            messages << Utils.generate_message(
                "Successful showing registration",
                "Your new showing has been added to the database!",
                "positive"
            )
        else
            messages << Utils.generate_message(
                "Failed showing registration",
                showing.errors.full_messages,
                "negative",
            )
        end
        return {
            result: showing.valid? ? showing : nil,
            messages: messages
        }
    end
end