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
		unless post.tags.empty?
			post.tags.each do |tag|				
				@posts << post if tag.title == params[:tag_title]	
			end
		end
	end

	if @posts.empty?	
		@no_tag = true
		@posts = Post.all
		erb :list_posts
	else 
		@tag_name = params[:tag_title]
		erb :list_by_tags
	end
end

get '/posts/edit' do
	@posts = Post.all
	@post = Post.find_by_title(params[:post_title])
	# @post = Post.find(params[:post][:id])
	if @post
		erb :edit_post
	else
		@wrong_title = true
		erb :list_posts
	end
end


#POST=====================================================
		
post '/posts/new' do 
	post = Post.new(params[:post])
	tag = Tag.where(title: params[:tag][:title]).first_or_initialize
	if post.valid?
		post.save
		tag.save
		post.tags << tag			
		redirect '/posts'
	else
		@invalid_post = true
		erb :create_post
	end
end

post '/posts/edit' do
	Post.find(params[:post][:id]).update_attributes(content: params[:post][:content])
		redirect '/posts'
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