class PositivePostsController < ApplicationController


	get '/positive_posts' do
		@positive_posts = PositivePost.all 
		erb :'positive_posts/index'
	end


	# get positive_posts/new to render a form to create a new entry
get '/positive_posts/new' do 
	erb :'/positive_posts/new'
end

# post positive_posts to create a new positive post
post '/positive_posts/new' do
    
	#new positive post and save it to db
	#only create a positive post if user is logged in
	redirect_if_not_logged_in
		
		#i only want to save the entry if it has content
		if params[:content] != ""
			flash[:message] = "You just added some positivity!"
			#create a new entry
			@positive_post = PositivePost.create(content: params[:content], user_id: current_user.id)
			redirect "/positive_posts/#{@positive_post.id}"
		else
			flash[:errors] = "You need to add some content to share a post"
			redirect '/positive_posts/new'
		end
	end
	
	#show route for a positive post
	get '/positive_posts/:id' do 
		set_positive_post
		erb :'/positive_posts/show'
	
	end

	#this route should send us to positive_posts/edit.erb
	# render an edit form 
	get '/positive_posts/:id/edit' do
		set_positive_post
		redirect_if_not_logged_in
		if authorized_to_edit?(@positive_post)
			erb :'/positive_posts/edit'
		else
			redirect "/users/#{current_user.id}"
		end
	end


	#this action 
	patch '/positive_posts/:id' do
		#1. find the positive post
		set_positive_post
		redirect_if_not_logged_in
		#2. update the positive post
		
			if @positive_post.user == current_user && params[:content] != ""
		@positive_post.update(content: params[:content])

		#3. redirect to show page 
		redirect "/positive_posts/#{@positive_post.id}"
			else  
				flash[:errors] = "You cannot submit a blank post"
				redirect "/positive_posts/#{@positive_post.id}/edit"
			end
		end
	
	delete '/positive_posts/:id' do 
		set_positive_post
		if authorized_to_edit?(@positive_post)
			#delete the entry
			#go somewhere
			@positive_post.destroy
			flash[:message] = "Successfully deleted that post"
			redirect '/positive_posts'
		else
			redirect '/positive_posts'
		end
	end

	
	
	#index route for all positive posts
	



	private 
	
	def set_positive_post
		@positive_post = PositivePost.find(params[:id])
	end
end

