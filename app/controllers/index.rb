get '/' do
  if @user #won't trigger if user=nil
    session[:user_id] = @user.id
    erb :index
  elsif @user = User.new
    @user.login_error
    redirect '/users/new'
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
   
  erb :sign_in
end

post '/sessions' do
  @user = User.authenticate(params)

  redirect '/'
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end

#----------- USERS -----------

get '/users/new' do
  
  erb :sign_up
end

post '/users' do
  @user = User.new(params[:user]) 
  redirect '/' if @user.save
  erb :sign_up
end
