require 'ap'
require "rubygems"
require 'active_record'
require './user_class.rb'
require './links_class.rb'
require './constants.rb'
set :port, 8080

gem 'mysql'

ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => "127.0.0.1",
  :username => "root",
  :password => "pass",
  :database =>"myhomepage_ruby"
})

enable :sessions
