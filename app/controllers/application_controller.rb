class ApplicationController < ActionController::Base
    # include ApplicationHelper

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

    def sign_out(user)
        if user && is_signed_in(user)
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
