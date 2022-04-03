class SessionsController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        if ["new", "create"].include?(action) && get_signed_in()
            if get_signed_in().admin?()
                redirect_to(root_url())
            else 
                redirect_to(new_booking_url())
            end
        end
    end

    def new()
        user_id = params[:user_id]
        request = params[:request]
        @user = User.find(user_id) if user_id
        if @user && @user.activate(request)
            @session_ = {
                email: @user.email,
                password: "",
                remembered: false
            }
            Utils.add_messages(
                flash.now,
                "Successful account activation",
                ["You may now try signing in your account."],
                "positive",
            )
        else
            @session_ = {
                email: "",
                password: "",
                remembered: false
            }
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
                    if @user.admin?
                        return redirect_to(root_url())
                    else
                        return redirect_to(new_booking_url())
                    end
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
