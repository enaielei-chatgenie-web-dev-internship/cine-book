class ApplicationController < ActionController::Base
    before_action() do |controller|
        action = controller.action_name
        if ["index"].include?(action) && !get_signed_in()
            redirect_to(new_session_url())
        end
    end

    def api()
        data = params[:data]
        type = params[:type]
        response = {}

        if type == "dropdown"
            response = {
                success: true,
                results: []
            }

            if data == "cinemas"
                for c in Cinema.all
                    response[:results] << {
                        name: c.name,
                        value: c.id,
                    }
                end
            elsif data == "movies"
                for m in Movie.all
                    response[:results] << {
                        name: m.title,
                        value: m.id,
                    }
                end
            elsif data == "showings"
                for s in Showing.all
                    response[:results] << {
                        name: "#{s.cinema.name} - #{s.movie.title} - #{s.timeslot.pretty_time}",
                        value: s.id,
                    }
                end
            elsif data == "showing-timeslots"
                cinema_id = params[:cinema_id]
                movie_id = params[:movie_id]
                cinema = Cinema.find(cinema_id)
                movie = Movie.find(movie_id)
                
                if cinema && movie
                    timeslots = Showing.timeslots(cinema, movie)
                    for t in timeslots
                        response[:results] << {
                            name: t.pretty_time + (
                                t.label && !t.label.empty? ?
                                " (#{t.label})" :
                                ""
                            ),
                            value: t.id
                        }
                    end
                else
                    response[:success] = false
                end
            elsif data == "booking-showings"
                for s in Showing.all
                    if s.seats_free.size != 0
                        response[:results] << {
                            name: "#{s.cinema.name} - #{s.movie.title} - #{s.timeslot.pretty_time}",
                            value: s.id,
                        }
                    end
                end
            elsif data == "booking-seats"
                showing_id = params[:showing_id]
                showing = Showing.find(showing_id)

                if showing
                    for s in showing.seats_free
                        response[:results] << {
                            name: s.to_s(),
                            value: s
                        }
                    end
                else
                    response[:success] = false
                end
            else
                response[:success] = false
            end
        end

        render(json: response)
    end


    def index()
        render("application/index")
    end

    def sign_in(user, remembered=false)
        if !remembered
            session[:user_id] = user.id
        else
            cookies.permanent.signed[:user_id] = user.id
            request = Utils.random()
            cookies.permanent[:request] = request
            user.update(session_digest: Utils.tokenize(request))
        end
    end

    def sign_out(user=nil)
        if user == nil || (user && is_signed_in(user))
            session[:user_id] = nil
            cookies.permanent.signed[:user_id] = nil
            cookies.permanent[:request] = nil
            user.update(session_digest: nil)
        end
    end

    def is_signed_in(user)
        return get_signed_in() == user
    end

    def get_signed_in()
        id = session[:user_id]
        request = nil
        if !id
            id = cookies.signed[:user_id]
            request = cookies[:request]
        end

        return nil if !id
        user = User.find_by(id: id)

        if user && request
            return user if Utils.compare(user.session_digest, request)
        end

        return user
    end

    def on_page(controller_name, *actions)
        return Utils.is_page(self, controller_name, *actions)
    end
end
