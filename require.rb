require 'ap'
require "rubygems"
require 'active_record'
require './user_class.rb'
require './links_class.rb'
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

$colour = {
  0 => "tile-blue" ,
  1 => "tile-green",
  2 => "tile-red",
  3 => "tile-yellow",
  4 => "tile-orange",
  5 => "tile-pink",
  6 => "tile-purple",
  7 => "tile-lime",
  8 => "tile-magenta",
  9 => "tile-teal"
   )