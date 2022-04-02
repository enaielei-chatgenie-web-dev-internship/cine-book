class ShowingsController < ApplicationController
    def new()
        @cinemas = Cinema.all
        @movies = Movie.all
        @timeslots = Timeslot.all        
        @showing = Showing.new()

        render("showings/new_showing")
    end
  
    def create()
        @cinemas = Cinema.all
        @movies = Movie.all
        @timeslots = Timeslot.all
        @showing = Showing.new(get_params())
        
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
  
    private()
  
    def get_params()
        return params.require(:showing).permit(
            :cinema_id, :movie_id, :timeslot_id
        )
    end
end
