class ShowingsController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        signed_in = get_signed_in()
        unless signed_in
            redirect_to(new_session_url())
        end
    end

    def show()
        @showing = Showing.find(params[:id])
        @seats = @showing.cinema.seats
        @seats_taken = @showing.seats_taken
        @seats_free = @showing.seats_free
        @seats_layout = @showing.seats_layout

        render("showings/view_showing")
    end

    def new() 
        @showing = Showing.new()
        @showings = Showing.all.page(params[:page]).per(params[:count] || 5)
        @cinemas = Cinema.all
        @movies = Movie.all

        render("showings/new_showing")
    end
  
    def create()
        @showing = Showing.new(get_params())
        @showings = Showing.all.page(params[:page]).per(params[:count] || 5)
        @cinemas = Cinema.all
        @movies = Movie.all
        
        if @showing.save()
            Utils.add_messages(
                flash,
                "Successful showing registration",
                "Your new showing has been added to the database!",
                "positive"
            )
            redirect_to(new_showing_url())
        else
            Utils.add_messages(
                flash.now,
                "Failed showing registration",
                @showing.errors.full_messages,
                "negative",
            )
            render("showings/new_showing", status: :unprocessable_entity)
        end
    end

    def destroy()
        @showing = Showing.find(params[:id])
        @showing.destroy()
        Utils.add_messages(
            flash,
            "Successful showing removal",
            ["Your showing has been removed!"],
            "positive"
        )
        redirect_to(new_showing_url())
    end
  
    private()
  
    def get_params()
        return params.require(:showing).permit(
            :cinema_id, :movie_id, :timeslot_id
        )
    end
end
