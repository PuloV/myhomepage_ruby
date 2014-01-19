require 'sinatra'
require "rubygems"
require 'active_record'
require "awesome_print"
ActiveRecord::Base.establish_connection ({
  :adapter => "mysql",
  :host => "127.0.0.1",
  :username => "root",
  :password => "pass",
  :database =>"myhomepage_ruby"
})

class Users < ActiveRecord::Base
  belongs_to :user
  def self.make(mail="user",password="pass")
    existing_user = Users.where(:user_email => mail)
    pass = Digest::MD5.hexdigest password.reverse
    Users.create(:user_email => mail , :user_password => pass )
  end

  def self.login(mail="user",password="pass")
    pass = Digest::MD5.hexdigest password.reverse
    current_user = Users.where(:user_email => mail , :user_password => pass )
    ap current_user.where_values_hash
    if current_user.size
      return current_user.where_values_hash
    else
     return false
    end

  end

end