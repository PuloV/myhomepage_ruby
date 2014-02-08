require 'ap'
require "rubygems"
require 'active_record'
require './helpers/constants.rb'
require './models/user.rb'
require './models/link.rb'
require './models/menu.rb'
require './models/news.rb'
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


require 'mail'

options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'localhost',
            :user_name            => 'myhomepage_ruby@gmail.com',
            :password             => 'myhomepage_ruby',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }



Mail.defaults do
  delivery_method :smtp, options
end