class BookingsController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        signed_in = get_signed_in()
        unless signed_in && signed_in.admin?
            redirect_to(new_session_url())
        end
    end

    def show()
        @showing = Showing.find(params[:id])
        @seats = @showing.cinema.seats
        @seats_taken = [3, 4, 10, 1]
        @seats_free = ((1..@seats).select() {|s| !@seats_taken.include?(s)})

        @cols = 5
        rem = @seats.modulo(@cols)
        @rows = (@seats - rem) / @cols
        @seats_layout = []
        count = 0
        for i in 1..@rows
            @seats_layout << []
            for i2 in 1..@cols
                count += 1
                @seats_layout.last << @seats_taken.include?(count)
            end
        end
        
        if rem > 0
            @seats_layout << []
            for i in 1..rem
                count += 1
                @seats_layout.last << @seats_taken.include?(count)
            end
        end

        render("showings/view_showing")
    end

    def new() 
        @showing = Showing.new()
        @showings = Showing.all.page(params[:page]).per(params[:count] || 10)
        @cinemas = Cinema.all
        @movies = Movie.all

        render("showings/new_showing")
    end
  
    def create()
        @showing = Showing.new(get_params())
        @showings = Showing.all.page(params[:page]).per(params[:count] || 10)
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
