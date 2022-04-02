class MoviesController < ApplicationController
  def new()
    @movie = Movie.new()

    render("movies/new_movie")
  end

  def create()
      @movie = Movie.new(get_params())
      
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

  private()

  def get_params()
      return params.require(:movie).permit(
          :title, :description,
      )
  end
end
