class TimeslotsController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        signed_in = get_signed_in()
        unless signed_in && signed_in.admin?
            redirect_to(new_session_url())
        end
    end

    def show()
        @timeslot = Timeslot.find(params[:id])
        @showings = @timeslot.showings.page(params[:page]).per(params[:count] || 10)

        render("timeslots/view_timeslot")
    end
    
    def new()
        @timeslot = Timeslot.new()
        @timeslots = Timeslot.all.page(params[:page]).per(params[:count] || 10)

        render("timeslots/new_timeslot")
    end

    def create()
        @timeslot = Timeslot.new(get_params())
        @timeslots = Timeslot.all.page(params[:page]).per(params[:count] || 10)
        
        if @timeslot.save()
            Utils.add_messages(
                flash,
                "Successful timeslot registration",
                "Your new timeslot has been added to the database!",
                "positive"
            )
            redirect_to(new_timeslot_url())
        else
            Utils.add_messages(
                flash.now,
                "Failed timeslot registration",
                @timeslot.errors.full_messages,
                "negative",
            )
            render("timeslots/new_timeslot", status: :unprocessable_entity)
        end
    end

    def destroy()
        @timeslot = Timeslot.find(params[:id])
        @timeslot.destroy()
        Utils.add_messages(
            flash,
            "Successful timeslot removal",
            ["Your timeslot has been removed!"],
            "positive"
        )
        redirect_to(new_timeslot_url())
    end

    private()

    def get_params()
        return params.require(:timeslot).permit(
            :time, :label,
        )
    end
end
