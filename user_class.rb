require './require.rb'

class User < ActiveRecord::Base
  has_many  :user_links
  has_many  :links , through: :user_links

  validates_format_of :user_email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ , :message =>  "Въведете валиден Email !"

  validates :user_email, length: {
    minimum: 9,
    maximum: 50,
    too_short: "Минимума на символи за Email е 9 ! ",
    too_long: "Надвишили сте максимума символи за Email който е 50 символа !"
  }



  def self.register(mail="user",password="pass")
    existing_user = User.where(:user_email => mail)
    pass = Digest::MD5.hexdigest password.reverse
    user = User.new
    user = User.create(:user_email => mail , :user_password => pass ) if password.size > 6 and existing_user.size == 0
    user.errors[:user_password] << "Паролата е прекалено къса !" if password.size < 6
    user.errors[:user_email] << "Това име вече е заето !" if existing_user.size > 0
    return user
  end

  def self.login(mail="user",password="pass")
    pass = Digest::MD5.hexdigest password.reverse
    current_user = User.find_by(user_email: mail , :user_password => pass )
    current_user = User.new unless current_user
    current_user.errors[:user_email] << "Грешен Email !" unless current_user and User.find_by(:user_email => mail )
    current_user.errors[:user_password] << "Грешена парола !" unless current_user and User.find_by(:user_password => pass  )

    apvalue current_user
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