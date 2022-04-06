class SessionsController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        if ["new", "create"].include?(action) && get_signed_in()
            redirect_to(root_url())
        end
    end

    def new()
        @session_ = params[:session] || {
            email: "",
            password: "",
            remembered: false
        }
        user_id = params[:user_id]
        request = params[:request]
        @user = User.find(user_id) if user_id
        if @user && @user.activate(request)
            @session_[:email] = @user.email
            Utils.add_messages(
                flash.now,
                "Successful account activation",
                ["You may now try signing in your account."],
                "positive",
            )
        end

        render("sessions/sign_in")
    end

    def create()
        @session_ = get_params()
        @user = User.find_by(email: @session_[:email])

        if @user
            if @user.authenticate(@session_[:password])
                if @user.activated?
                    remembered = @session_[:remembered]
                    remembered = remembered && !remembered.empty?() && remembered != "0"
                    sign_in(@user, remembered)
                    return redirect_to(root_url())
                else
                    Utils.add_messages(
                        flash.now,
                        "Failed account log in",
                        ["Account is not yet activated. Please check your email for the activation link."],
                        "negative",
                    )
                end
            else
                Utils.add_messages(
                    flash.now,
                    "Failed account log in",
                    ["Password is incrorrect"],
                    "negative",
                )
            end
        else
            Utils.add_messages(
                flash.now,
                "Failed account log in",
                ["Email does not exist"],
                "negative",
            )
        end

        render("sessions/sign_in", status: :unprocessable_entity)
    end

    def destroy()
        @user = User.find(params[:user_id])
        if @user
            sign_out(@user)
            redirect_to(root_url()) if !get_signed_in()
        end
    end

    private()

    def get_params()
        return params.require(:session).permit(
            :email, :password, :remembered
        )
    end
end
