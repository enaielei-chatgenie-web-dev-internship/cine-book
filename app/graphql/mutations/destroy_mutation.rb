class Mutations::DestroyMutation < Mutations::BaseMutation
    argument(:condition, String, required: true)
    argument(:values, [String], required: false, default_value: [])

    private()

    def destroy(
        result,
        condition,
        *values
    )
        result = result.destroy_by(condition, *values)
        messages = []

        if result.size > 0 
            messages << Utils.generate_message(
                "Successful Deletion",
                "A total of #{result.size} record(s) were deleted.",
                "positive"
            )
        else
            messages << Utils.generate_message(
                "Failed Deletion",
                "No record(s) to delete.",
                "negative",
            )
        end
        return {
            result: result,
            messages: messages
        }
    end
end