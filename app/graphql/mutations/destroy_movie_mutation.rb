class Mutations::DestroyMovieMutation < Mutations::DestroyMutation
    field(:result, [Types::MovieType], null: false)

    def resolve(
        condition:,
        values: nil
    )
        return self.destroy(Movie, condition, *values)
    end
end