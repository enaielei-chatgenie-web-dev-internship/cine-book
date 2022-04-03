class BookingsController < ApplicationController
    def new()
        @seats = (1..10).to_a()
        @showings = Showing.all
        @booking = Booking.new()
    
        render("bookings/new_booking")
    end
  
    def create()
        @seats = (1..10).to_a()
        @showings = Showing.all
        @booking = Booking.new(get_params())

        if @booking.save()
            Utils.add_messages(
                flash,
                "Successful booking registration",
                "Your new booking has been added to the database!",
                "positive"
            )
            redirect_to(new_booking_url())
        else
            Utils.add_messages(
                flash.now,
                "Failed booking registration",
                @booking.errors.full_messages,
                "negative",
            )
            render("bookings/new_booking", status: :unprocessable_entity)
        end
    end
  
    private()
  
    def get_params()
        return params.require(:booking).permit(
            :showing_id, :user_id, :seat
        )
    end
end
