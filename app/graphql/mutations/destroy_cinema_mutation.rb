class Mutations::DestroyCinemaMutation < Mutations::DestroyMutation
    field(:result, [Types::CinemaType], null: false)

    def resolve(
        condition:,
        values: nil
    )
        return self.destroy(Cinema, condition, *values)
    end
end