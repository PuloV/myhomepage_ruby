require 'sinatra'
require './require.rb'

before do
  #redirect to('/user/login') if session["logged"].inspect && request.path != "/user/login" && request.path != "/user/register"
end

post '/user/register' do
  Users.make params[:emailreg] , params[:passwordreg]
  redirect to('/user/login')
end

post '/user/login' do
  current_user = Users.login params[:email] , params[:password]

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

get '/user/:task' do |task|
  erb task.to_sym
end
get '/' do
  test = Users.all
  numb = rand(1..3)
  Links.make(numb)
  erb "User № 1 = #{test.size} <br /> Rand = #{numb}"



end