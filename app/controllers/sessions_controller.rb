class SessionsController < ApplicationController
    before_action :require_logged_in, only: [:destroy]
    before_action :require_logged_out, only: [:new, :create]

    def new
        # gimme the login form
        @user = User.new
        render :new
    end

    def create
        # login
        # find the user by their credentials
        @user = User.find_by_credentials(
            params[:user][:username], 
            params[:user][:password]
        )

        # if we found the user
            # log them in
            # send them to home page or something like it
        # else
            # show them the login form again, with some errors probably
        if @user
            login(@user)
            # use flash if redirecting
            redirect_to users_url
        else
            flash.now[:errors] = ["Invalid credentials"] # use flash.now when rendering
            render :new
        end
    end

    def destroy
        # logout
        logout!
        redirect_to new_session_url
    end
end

