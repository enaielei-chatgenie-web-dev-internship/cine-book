class User < ApplicationRecord
    include BCrypt

    has_many(:bookings)

    validates(
        :email,
        # presence: true,
        # length: {maximum: 75},
        format: {
            with: $VALID_EMAIL_REGEX,
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
            message: "must be a valid mobile number"
        }
    )
    validates(
        :password,
        # presence: true,
        confirmation: true,
        length: {minimum: 6},
        allow_nil: true
    )

    before_save() do
        self.email = email.downcase()
    end

    has_secure_password(validations: false)

    def activate(request)
        return self.activated? if self.activated?
        self.update(activated: Utils.compare(self.activation_digest, request))
        return self.activated?
    end

    # def sign_in(session, cookies, remembered=false)
    #     if !remembered
    #         session[:user_id] = self.id
    #     else
    #         cookies.permanent.signed[:user_id] = self.id
    #         request = Utils.random()
    #         cookies.permanent[:request] = request
    #         self.update(session_digest: Utils.tokenize(request))
    #     end
    # end

    # def sign_out(session, cookies)
    #     user = User.get_signed_in()
    #     if user == self
    #         session[:user_id] = nil
    #         cookies.permanent.signed[:user_id] = nil
    #         cookies.permanent[:request] = nil
    #         self.update(session_digest: nil)
    #     end
    # end

    # def signed_in()
    #     return User.get_signed_in() == self
    # end

    # def self.get_signed_in(session, cookies)
    #     id = session[:user_id]
    #     request = nil
    #     if !id
    #         id = cookies[:user_id]
    #         request = cookies[:request]
    #     end

    #     return nil if !id
    #     user = User.find(id)

    #     if user && request
    #         return user if Utils.compare(user.session_digest, request)
    #     end

    #     return user
    # end
end
