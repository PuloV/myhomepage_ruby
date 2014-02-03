require 'ap'
require "rubygems"
require 'active_record'
require './user_class.rb'
require './link_class.rb'
require './constants.rb'
require './menu_class.rb'
require 'utf8'
require "awesome_print"
set :port, 8080


gem 'mysql'

ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => "127.0.0.1",
  :username => "root",
  :password => "pass",
  :database =>"myhomepage_ruby",
  :encoding => "ascii"
})

enable :sessions
