class PagesController < ApplicationController
    def index
        if current_user
            redirect_to posts_path
        else
            redirect_to signin_path
        end
    end
end
