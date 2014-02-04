require './require.rb'

class User < ActiveRecord::Base
  has_many  :user_links
  has_many  :links , through: :user_links

  validates_format_of :user_email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ , :message =>  "Въведете валиден Email !"

  validates :user_email, length: {
    minimum: 9,
    maximum: 50,
   # tokenizer: lambda { |str|  apvalue  str.scan(/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/) ;  str.scan(/\A[^@]+@([^@\.]+\.)+[^@\.]+\z/) },
    too_short: "Минимума на символи е 9 ! ",
    too_long: "Надвишили сте максимума който е 50 символа !"
  }


  def self.register(mail="user",password="pass")
    existing_user = User.where(:user_email => mail)
    pass = Digest::MD5.hexdigest password.reverse
    user = User.create(:user_email => mail , :user_password => pass )
    apvalue user.errors
    return user
  end

  def self.login(mail="user",password="pass")
    pass = Digest::MD5.hexdigest password.reverse
    current_user = User.find_by(user_email: mail , :user_password => pass )

    return current_user
 #   if current_user
 #    return current_user
 #   else
  #   return false
#    end
  end

  def make_bookmark(user=0,title="The title",link="http://")
    user_link = Link.make link
    self.user_links.create({:user_link_name => title , :user_id => user , :link_id => user_link.link_id})
  end

end