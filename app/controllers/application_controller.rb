class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        else
            @current_user = nil
        end
    end

    def user_logged_in?
        return !!current_user
    end

    def check
        if(!user_logged_in?)
          redirect_to '/'
        end
    end
end
