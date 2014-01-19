require 'sinatra'
require "rubygems"
require 'active_record'
set :port, 8080


gem 'mysql'

test = ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => "127.0.0.1",
  :username => "root",
  :password => "pass",
  :database =>"homepage"
})

class Users < ActiveRecord::Base
end

enable :sessions

before do
  #redirect to('/user/login') if session["logged"].inspect && request.path != "/user/login" && request.path != "/user/register"

end

get '/user/:task' do |task|
  erb task.to_sym
end
get '/' do
  test =  Users.find(:first).user_name
  erb "User № 1 = #{test}"

end