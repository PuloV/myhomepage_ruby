require './require.rb'
require './constants.rb'
class User < ActiveRecord::Base
  has_many  :user_links
  has_many  :links , through: :user_links

  validates_format_of :user_email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ , :message => Constants::NOTVALID_EMAIL

  validates :user_email, length: {
    minimum: Constants::EMAIL_MIN_LENGHT,
    maximum: Constants::EMAIL_MAX_LENGHT,
    too_short: Constants::EMAIL_TOO_SHORT,
    too_long: Constants::EMAIL_TOO_LONG
  }



  def self.register(mail="user",password="pass")
    existing_user = User.where(:user_email => mail)
    pass = Digest::MD5.hexdigest password.reverse
    user = User.new
    user = User.create(:user_email => mail , :user_password => pass ) if password.size > Constants::PASSWORD_MIN_LENGHT and existing_user.size == 0
    user.errors[:user_password] << Constants::SHORT_PASSWORD if password.size < Constants::PASSWORD_MIN_LENGHT
    user.errors[:user_email] << Constants::USERNAME_TAKEN if existing_user.size > 0
    return user
  end

  def self.login(mail="user",password="pass")
    pass = Digest::MD5.hexdigest password.reverse
    current_user = User.find_by(user_email: mail , :user_password => pass )
    current_user = User.new unless current_user
    current_user.errors[:user_email] << Constants::WRONG_EMAIL unless current_user and User.find_by(:user_email => mail )
    current_user.errors[:user_password] << Constants::WRONG_PASSWORD unless current_user and User.find_by(:user_password => pass  )
    return current_user
  end

  def make_bookmark(user=0,title="The title",link="http://")
    user_link = Link.make link
    return user_link if user_link.errors.messages.any?
    self.user_links.create({:user_link_name => title , :user_id => user , :link_id => user_link.link_id})
  end
end
