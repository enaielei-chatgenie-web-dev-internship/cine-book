class BookingsController < ApplicationController
    before_action() do |controller|
        action = controller.action_name
        signed_in = get_signed_in()
        unless signed_in
            redirect_to(new_session_url())
        end
    end

    def show()
        @booking = Booking.find(params[:id])
        @seats = @booking.showing.seats
        @seats_taken = @booking.showing.seats_taken
        @seats_free = @booking.showing.seats_free
        @seats_layout = @booking.showing.seats_layout

        render("bookings/view_booking")
    end

    def new()
        signed_in = get_signed_in()

        @booking = Booking.new(params[:booking] ? get_params() : nil)
        @bookings = signed_in && signed_in.admin? ? Booking.all.page(params[:page]).per(params[:count] || 5) : signed_in.bookings.page(params[:page]).per(params[:count] || 5)
        @showings = Showing.all
        @showing = @booking.showing
        @seats_free = @showing ? @showing.seats_free : []

        render("bookings/new_booking")
    end
  
    def create()
        signed_in = get_signed_in()

        @booking = Booking.new(get_params())
        @bookings = signed_in && signed_in.admin? ? Booking.all.page(params[:page]).per(params[:count] || 5) : signed_in.bookings.page(params[:page]).per(params[:count] || 5)
        @showings = Showing.all

        if @booking.user != get_signed_in()
            Utils.add_messages(
                flash.now,
                "Failed booking registration",
                ["User must be valid"],
                "negative",
            )
            return render("bookings/new_booking", status: :unprocessable_entity)
        end
        
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

    def destroy()
        @booking = Booking.find(params[:id])
        @booking.destroy()
        Utils.add_messages(
            flash,
            "Successful booking removal",
            ["Your booking has been removed!"],
            "positive"
        )
        redirect_to(new_booking_url())
    end
  
    private()
  
    def get_params()
        return params.require(:booking).permit(
            :showing_id, :user_id, :seat
        )
    end
end
