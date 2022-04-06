class User < ApplicationRecord
    include BCrypt

    has_many(:bookings)

    validates(
        :email,
        # presence: true,
        # length: {maximum: 75},
        uniqueness: true,
        format: {
            with: URI::MailTo::EMAIL_REGEXP,
            message: "must be a valid email address"
        }
    )
    validates(
        :full_name,
        presence: true,
        length: {maximum: 100}
    )

    validates(
        :mobile_number,
        # presence: true,
        format: {
            with: $VALID_MOBILE_NUMBER_REGEX,
            message: "must be a valid"
        }
    )
    validates(
        :password,
        # presence: true,
        confirmation: true,
        length: {minimum: 6},
        allow_nil: true
    )

    has_secure_password(validations: true)

    before_save() do
        self.email = email.downcase()
    end

    def activate(request)
        return self.activated? if self.activated?
        self.update(activated: Utils.compare(self.activation_digest, request))
        return self.activated?
    end
end
