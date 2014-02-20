get '/posts' do 
	@posts = Post.all
	erb :list_posts
end



get '/posts/new' do
	erb :create_post
end

get '/posts/by_tag' do
	@posts = []
	Post.all.each do |post|
		# binding.pry
		unless post.tags.empty?
			post.tags do |tag|
				
				@posts << post if tag.title == params[:tag_title]	
			end
		end
	end		
	erb :list_by_tags
end


#POST=====================================================
		
post '/posts/new' do 
	post = Post.new(params[:post])
	tag = Tag.new(params[:tag])
	if post.valid?
		if tag.valid?
			# post.save
			# tag.save
			post.tags << tag			
			redirect '/posts'
		else
			@invalid_tag = true
			erb :create_post
		end
	else
		@invalid_post = true
		erb :create_post
	end
end

post '/posts/delete' do
	post = Post.find_by_title(params[:post_title])
	if post 
		post.delete
		redirect '/posts'
	else
		@wrong_title = true
		@posts = Post.all
		erb :list_posts
	end
end