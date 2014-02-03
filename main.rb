require 'sinatra'
require './require.rb'
require './user.rb'
require './bookmarks.rb'
require './charts.rb'
require './charts.rb'
before do
  @user_menu = false
  @user_menu = Menu.where(:menu_type => 1) if session["logged"]
  @top_layer_menu = Menu.where(:menu_type => 0)
 # redirect to('../user/login') if session["logged"] != true  || ( request.path != "/user/login" || request.path != "/user/register")
end






get '/user/:task' do |task|
  erb task.to_sym
end

get '/' do
  u = User.where(:user_id => session["user_id"]).first
  name ="Link numb #{rand(1000..100000)}"
  url ="http://#{rand(0..1000)}"
  u.make_bookmark session["user_id"] , name , url

  erb "User № 1 = #{User.all.size} <br /> Link № 1 = #{Link.all.size} <br /> Name = #{name} <br /> URL = #{url} <br />"


end