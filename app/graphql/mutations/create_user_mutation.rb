class Mutations::CreateUserMutation < Mutations::BaseMutation
    argument(:email, String, required: true)
    argument(:full_name, String, required: true)
    argument(:mobile_number, String, required: true)
    argument(:password, String, required: true)
    argument(:password_confirmation, String, required: true)
    argument(:admin, Boolean, required: false, default_value: false)

    field(:result, Types::UserType, null: true)

    def resolve(
        email:,
        full_name:,
        mobile_number:,
        password:,
        password_confirmation:,
        admin: nil
    )
        user = User.new(
            email: email,
            full_name: full_name,
            mobile_number: mobile_number,
            password: password,
            password_confirmation: password_confirmation,
            admin: admin
        )
        messages = []
        if user.save()
            user.update(activated: true)
            messages << Utils.generate_message(
                "Successful account registration",
                "You can try logging in your account now.",
                "positive"
            )
        else
            messages << Utils.generate_message(
                "Failed account registration",
                user.errors.full_messages,
                "negative",
            )
        end
        return {
            result: user.valid? ? user : nil,
            messages: messages
        }
    end
end