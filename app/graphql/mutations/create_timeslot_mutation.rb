class Mutations::CreateTimeslotMutation < Mutations::BaseMutation
    argument(:time, GraphQL::Types::ISO8601DateTime, required: true)
    argument(:label, String, required: false)

    field(:result, Types::TimeslotType, null: true)

    def resolve(
        time:,
        label: nil
    )
        timeslot = Timeslot.new(
            time: time,
            label: label,
        )
        messages = []
        if timeslot.save()
            messages << Utils.generate_message(
                "Successful timeslot registration",
                "Your new timeslot has been added to the database!",
                "positive"
            )
        else
            messages << Utils.generate_message(
                "Failed timeslot registration",
                timeslot.errors.full_messages,
                "negative",
            )
        end
        return {
            result: timeslot.valid? ? timeslot : nil,
            messages: messages
        }
    end
end