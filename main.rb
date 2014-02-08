require 'sinatra'
require './require.rb'
require './helpers/user.rb'
require './helpers/bookmarks.rb'
require './helpers/charts.rb'
require './helpers/news.rb'


before do
  @user_menu = false
  @user_menu = Menu.where(:menu_type => 1) if session["logged"]
  @top_layer_menu = Menu.where(:menu_type => 0  , :menu_for_logged => session["logged"])
  allowed_paths = ["/news" , "/user/register" , "/user/login" , "/register" , "/login"   ]
  redirect to('../user/login') if session["logged"] != true  and !allowed_paths.include? request.path
end

get '/' do
 redirect to('../news')
end