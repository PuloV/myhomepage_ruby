
require "rubygems"
require 'active_record'
require './helpers/constants.rb'
require './models/user.rb'
require './models/link.rb'
require './models/menu.rb'
require './models/news.rb'
require 'utf8'
require "awesome_print"
require 'mail'
gem 'mysql'
set :port, 8080
set :session_secret, 'myhomepage'



ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => Constants::HOST,
  :username => Constants::HOST_USER,
  :password => Constants::HOST_PASSWORD,
  :database => Constants::HOST_DATABASE,
  :encoding => "utf8",
  :collation =>"utf8_general_ci"
})

enable :sessions


def apvalue(value)
  puts "\n ============================================== \n"
  ap value
  puts "\n ============================================== \n"
end




options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'localhost',
            :user_name            => 'myhomepage@gmail.com',
            :password             => 'myhomepage',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }



Mail.defaults do
  delivery_method :smtp, options
end