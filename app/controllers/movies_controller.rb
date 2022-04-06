class MoviesController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        signed_in = get_signed_in()
        unless signed_in && signed_in.admin?
            redirect_to(new_session_url())
        end
    end

    def show()
        @movie = Movie.find(params[:id])
        @showings = @movie.showings.page(params[:page]).per(params[:count] || 10)

        render("movies/view_movie")
    end

    def new()
        @movie = Movie.new()
        @movies = Movie.all.page(params[:page]).per(params[:count] || 10)

        render("movies/new_movie")
    end

    def create()
        @movie = Movie.new(get_params())
        @movies = Movie.all.page(params[:page]).per(params[:count] || 10)
        
        if @movie.save()
            Utils.add_messages(
                flash,
                "Successful movie registration",
                "Your new movie has been added to the database!",
                "positive"
            )
            redirect_to(new_movie_url())
        else
            Utils.add_messages(
                flash.now,
                "Failed movie registration",
                @movie.errors.full_messages,
                "negative",
            )
            render("movies/new_movie", status: :unprocessable_entity)
        end
    end

    def destroy()
        @movie = Movie.find(params[:id])
        @movie.destroy()
        Utils.add_messages(
            flash,
            "Successful movie removal",
            ["Your movie has been removed!"],
            "positive"
        )
        redirect_to(new_movie_url())
    end

    private()

    def get_params()
        return params.require(:movie).permit(
            :title, :description, :image
        )
    end
end
