require 'sinatra'
require './require.rb'
ActiveRecord::Base.clear_active_connections!
before do
  #redirect to('/user/login') if session["logged"].inspect && request.path != "/user/login" && request.path != "/user/register"
end

post '/user/register' do
  u = User.register params[:emailreg] , params[:passwordreg]
  ap u
  redirect to('/user/login')
end

post '/user/add' do
  user = User.where(:user_id => session["user_id"]).first
  user.make_bookmark user.user_id , params[:title] , params[:url]
  redirect to('/user/bookmarks')
end

post '/user/login' do
  current_user = params[:email]  ?  (User.login params[:email] , params[:password]) : (User.login params[:emailtop] , params[:passwordtop])
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

get '/bookmarks'  do
  u = User.where(:user_id => session["user_id"]).first
  links = {}
  u.user_links.map.with_index { |link , index| links[index] = {
    :user_link_name => link.user_link_name ,
    :link_source => u.links[index].link_source ,
    :link_id => link.link_id
    } }
  erb :bookmarks ,:locals => { :links => links  , :color => Constants::COLORS}

end

get '/user/:task' do |task|
  erb task.to_sym , :locals => { :integers => { 0 => 1  } }
end

get '/' do
  u = User.where(:user_id => session["user_id"]).first
  name ="Link numb #{rand(1000..100000)}"
  url ="http://#{rand(0..1000)}"
  u.make_bookmark session["user_id"] , name , url
  #ap u.links.methods - Object.methods
 # puts "tova sa potrebitelskite zapisi za linkove\n".upcase
 # ap u.user_links
  #puts " tova sa linkovete \n".upcase
  #ap u.links
  erb "User № 1 = #{User.all.size} <br /> Link № 1 = #{Link.all.size} <br /> Name = #{name} <br /> URL = #{url} <br />"


end