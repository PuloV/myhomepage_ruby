require 'sinatra'
require './require.rb'

before do
  #redirect to('/user/login') if session["logged"].inspect && request.path != "/user/login" && request.path != "/user/register"
end

post '/user/register' do
  u = User.register params[:emailreg] , params[:passwordreg]
  ap u
  redirect to('/user/login')
end

post '/user/login' do
  current_user = User.login params[:email] , params[:password]
  if current_user
    session["logged"] = true
    session["username"] = current_user['user_email']
    session["user_id"] = current_user['user_id']
    redirect to('/user/bookmarks')
  else
    session["logged"] = false
    redirect to('/user/register')
  end
end

get '/user/logout' do
    session["logged"] = false
    session["username"] = nil
    session["user_id"] = nil
    redirect to('/user/login')

end

get '/user/:task' do |task|
  erb task.to_sym
end

get '/' do
  u = User.where(:user_id => session["user_id"]).first
  ap u
  u.make_bookmark(session["user_id"],rand(1000..100000).to_s,rand(0..1000).to_s)
  ap u.user_links
  erb "User № 1 = #{User.all.size} <br /> Rand = #{1} <br /> "


end