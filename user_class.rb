require './require.rb'

class User < ActiveRecord::Base
  has_many  :user_links
  has_many  :links , through: :user_links
  def self.register(mail="user",password="pass")
    existing_user = User.where(:user_email => mail)
    pass = Digest::MD5.hexdigest password.reverse
    User.create(:user_email => mail , :user_password => pass )
  end

  def self.login(mail="user",password="pass")
    pass = Digest::MD5.hexdigest password.reverse
    current_user = User.find_by(user_email: mail , :user_password => pass )

    if current_user
      return current_user
    else
     return false
    end
  end

  def make_bookmark(user=0,title="The title",link="http://")
    user_link = Link.make link
   # ap self.user_links.methods - Object.methods
    self.user_links.create({:user_link_name => title , :user_id => user , :link_id => user_link.link_id})
   # UserLink.create({:user_link_name => title , :user_id => user , :link_id => users_link.link_id})
  end

end