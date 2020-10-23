require './config/environment'



# controller - where we navigate the user in our application
# set up routes & inside the routes have logic we want executed
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "positive_posts_app"
    register Sinatra::Flash
  end

  get "/" do
    if logged_in? 
      redirect "/users/#{current_user.id}"
    else
    erb :welcome 
  end
end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

		def logged_in? #helper method to check if any user is logged in
      !!current_user
    end

    def authorized_to_edit?(positive_post)
      positive_post.user == current_user
  end
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in view that page"
        redirect '/'
      end
    end
  end
end




