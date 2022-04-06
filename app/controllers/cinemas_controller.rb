class CinemasController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        signed_in = get_signed_in()
        unless signed_in && signed_in.admin?
            redirect_to(new_session_url())
        end
    end

    def show()
        @cinema = Cinema.find(params[:id])
        @showings = @cinema.showings.page(params[:page]).per(params[:count] || 10)

        render("cinemas/view_cinema")
    end

    def new()
        @cinema = Cinema.new()
        @cinemas = Cinema.all.page(params[:page]).per(params[:count] || 10)

        render("cinemas/new_cinema")
    end

    def create()
        @cinema = Cinema.new(get_params())
        @cinemas = Cinema.all.page(params[:page]).per(params[:count] || 10)
        
        if @cinema.save()
            Utils.add_messages(
                flash,
                "Successful cinema registration",
                "Your new cinema has been added to the database!",
                "positive"
            )
            redirect_to(new_cinema_url())
        else
            Utils.add_messages(
                flash.now,
                "Failed cinema registration",
                @cinema.errors.full_messages,
                "negative",
            )
            render("cinemas/new_cinema", status: :unprocessable_entity)
        end
    end

    def destroy()
        @cinema = Cinema.find(params[:id])
        @cinema.destroy()
        Utils.add_messages(
            flash,
            "Successful cinema removal",
            ["Your cinema has been removed!"],
            "positive"
        )
        redirect_to(new_cinema_url())
    end

    private()

    def get_params()
        return params.require(:cinema).permit(
            :name, :location, :seats, :image
        )
    end
end
