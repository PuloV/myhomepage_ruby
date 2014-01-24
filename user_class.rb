require './require.rb'

class Users < ActiveRecord::Base
  has_many :links , through: :user_has_links
  def self.make(mail="user",password="pass")
    existing_user = Users.where(:user_email => mail)
    pass = Digest::MD5.hexdigest password.reverse
    Users.create(:user_email => mail , :user_password => pass )
  end

  def self.login(mail="user",password="pass")
    pass = Digest::MD5.hexdigest password.reverse
    current_user = Users.find_by(user_email: mail , :user_password => pass )
    ap "\n====\n"
    ap current_user
    ap "\n====\n"
    if current_user
      return current_user
    else
     return false
    end

  end

end