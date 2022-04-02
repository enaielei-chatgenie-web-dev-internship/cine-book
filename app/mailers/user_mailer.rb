class UserMailer < ApplicationMailer
    def account_activation(user)
        @user = user
        @request = Utils.random()
        @user.update(activation_digest: Utils.tokenize(@request))
        @url = new_session_url(user_id: @user.id, request: @request)
        return mail(
            to: @user.email,
            subject: "CineBook | Account Activation"
        )
    end
end
