class Mutations::DestroyShowingMutation < Mutations::DestroyMutation
    field(:result, [Types::ShowingType], null: false)

    def resolve(
        condition:,
        values: nil
    )
        return self.destroy(Showing, condition, *values)
    end
end