class TimeslotsController < ApplicationController
  def new()
    @timeslot = Timeslot.new()

    render("timeslots/new_timeslot")
  end

  def create()
      @timeslot = Timeslot.new(get_params())
      
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

  private()

  def get_params()
      return params.require(:timeslot).permit(
          :title, :description,
      )
  end
end
