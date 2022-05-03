class Mutations::CreateMovieMutation < Mutations::BaseMutation
    argument(:title, String, required: true)
    argument(:description, String, required: false)

    field(:result, Types::MovieType, null: true)

    def resolve(
        title:,
        description: nil
    )
        movie = Movie.new(
            title: title,
            description: description,
        )
        messages = []
        if movie.save()
            messages << Utils.generate_message(
                "Successful movie registration",
                "Your new movie has been added to the database!",
                "positive"
            )
        else
            messages << Utils.generate_message(
                "Failed movie registration",
                movie.errors.full_messages,
                "negative",
            )
        end
        return {
            result: movie.valid? ? movie : nil,
            messages: messages
        }
    end
end