class Mutations::DestroyTimeslotMutation < Mutations::DestroyMutation
    field(:result, [Types::TimeslotType], null: false)

    def resolve(
        condition:,
        values: nil
    )
        return self.destroy(Timeslot, condition, *values)
    end
end