get '/' do

  @users = User.all

  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do

  erb :sign_in
end

post '/sessions' do
  user = User.authenticate(params[:email], params[:password])

  if user
    session[:user_id] = user.id
  end

  redirect '/'
end

delete '/sessions/:id' do
  session.clear
end

#----------- USERS -----------

get '/users/new' do

  erb :sign_up
end

post '/users' do
  user = User.new(name: params[:user][:name], email: params[:user][:email]) 
  user.password= params[:user][:password]
  user.save!
  
  session[:user_id]= user.id  
  
  redirect '/'
end
