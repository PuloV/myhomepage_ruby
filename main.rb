require 'sinatra'
require "rubygems"
require 'active_record'
require './user_class.rb'
set :port, 8080


gem 'mysql'

test = ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => "127.0.0.1",
  :username => "root",
  :password => "pass",
  :database =>"myhomepage_ruby"
})



enable :sessions

before do
  #redirect to('/user/login') if session["logged"].inspect && request.path != "/user/login" && request.path != "/user/register"

end
class Users < ActiveRecord::Base
end
post '/user/register' do
  Users.new params[:userreg] , params[:passwordreg]
  redirect to('/user/login')
end

get '/user/:task' do |task|
  erb task.to_sym
end
get '/' do
  test = User.all
  erb "User № 1 = #{test.size}"

end