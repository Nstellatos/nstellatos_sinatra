class UsersController < ApplicationController #access to any methods created in AC/congif, helper methods
	
	#what routes do I need for someone to login?
	
	#the purpose of this route is to render the login page(form)
	get '/login' do
		erb :login 
	end
	#the purpose of this route is to rec the login form
	#find the user, & log the user in (create a session)
	post '/login' do
		#find the user
		@user = User.find_by(email: params[:email])
		#authenticate the user - verify the user is who they say they are
		#they have the right credentials - email/password combo
		if @user && @user.authenticate(params[:password])
			#log the user in - create the user session
			session[:user_id] = @user.id #actually logging the user in
			#redirect to the users show page
			puts session
			flash[:message] = "Welcome, #{@user.name}"
			redirect "users/#{@user.id}"
		else
			flash[:errors] = "Your credentials were invalid. Please sign up or try again."
		redirect '/login'
		end
	end



	
	#what routes do I need for signup?
	#this routes job is to render the sign up form
	get '/signup' do 
		#erb (render) a view 
		erb :signup
	end

	post '/users' do #only job is to create a new user
		#here is where a new user is created & persists data to DB
		#params hash looks like "name" => "nicole", "email" => "nicole@nicole", "password"=>"nicole"
		@user = User.new(params)
		if @user.save
		
		session[:user_id] = @user.id  #logs the user in
		flash[:message] = "You have successfully created an account. #{@user.name}! Welcome!"
		redirect "/users/#{@user.id}" #once new user is created it redirects you to show page/ get '/users/:id'
		
		else 
			flash[:errors] = "Account creation failure. #{@user.errors.full_messages.to_sentence} "
			redirect '/signup' 
		end
	end



	
#user SHOW route
#:id is a dynamic route.. Sinatra knows it can change, key in params hash
get '/users/:id' do 
	@user = User.find_by(id: params[:id]) #instance var retrieve the user from db
	redirect_if_not_logged_in
	erb :'/users/show'
end

get '/logout' do 
	session.clear 
	redirect '/'
end


end