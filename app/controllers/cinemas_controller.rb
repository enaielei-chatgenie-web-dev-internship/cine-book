class CinemasController < ApplicationController
  def new()
    @cinema = Cinema.new()

    render("cinemas/new_cinema")
  end

  def create()
      @cinema = Cinema.new(get_params())
      
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

  private()

  def get_params()
      return params.require(:cinema).permit(
          :name, :location, :seat,
      )
  end
end
