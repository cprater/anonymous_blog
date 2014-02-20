get '/posts' do 
	@posts = Post.all
	erb :list_posts
end



get '/posts/new' do
	erb :create_post
end

# get '/posts/delete' do

# end










#POST=========================

post '/posts/new' do 
	Post.create(params[:post])
	redirect '/posts'
end

post '/posts/delete' do
	# post = Post.where(title: params[:post_title]).first  
	Post.find_by_title(params[:post_title]).destroy  #not grabbing titles with trailing whitespace
	erb :list_posts
	# binding.pry
end