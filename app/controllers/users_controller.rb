class UsersController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        if ["new", "create"].include?(action) && get_signed_in()
            redirect_to(root_url())
        end
    end

    def new()
        @user = User.new()
        render("users/sign_up")
    end

    def create()
        @user = User.new(get_params())
        
        if @user.save()
            UserMailer.account_activation(@user).deliver_now()
            Utils.add_messages(
                flash,
                "Successful account registration",
                "Please check your email for account activation.",
                "info"
            )
            redirect_to(new_user_url())
        else
            Utils.add_messages(
                flash.now,
                "Failed account registration",
                @user.errors.full_messages,
                "negative",
            )
            render("users/sign_up", status: :unprocessable_entity)
        end
    end

    private()

    def get_params()
        return params.require(:user).permit(
            :email, :full_name, :mobile_number,
            :password,
            :password_confirmation
        )
    end
end
