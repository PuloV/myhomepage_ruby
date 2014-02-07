require 'ap'
require "rubygems"
require 'active_record'
require './user_class.rb'
require './link_class.rb'
require './constants.rb'
require './menu_class.rb'
require './news_class.rb'
require 'utf8'
require "awesome_print"
set :port, 8080


gem 'mysql'

ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => Constants::HOST,
  :username => Constants::HOST_USER,
  :password => Constants::HOST_PASSWORD,
  :database => Constants::HOST_DATABASE,
  :encoding => "ascii"
})

enable :sessions


def apvalue(value)
  puts "\n ============================================== \n"
  ap value
  puts "\n ============================================== \n"
end