require 'sinatra'
require "rubygems"
require 'active_record'
ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => "127.0.0.1",
  :username => "root",
  :password => "pass",
  :database =>"myhomepage_ruby"
})
class Users < ActiveRecord::Base
 belongs_to :user
  def self.initializew(mail="user",password="pass")
    existing_user =  Users.where(user_email: mail)
    pass = Digest::MD5.hexdigest password.reverse
    Users.create(:user_email => mail , :user_password => pass )
  end

end