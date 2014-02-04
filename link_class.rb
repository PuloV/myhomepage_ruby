require './require.rb'
require './constants.rb'

class Link < ActiveRecord::Base
  has_many  :user_links
  has_many  :users , through: :user_links
  validates :link_source, length: {
    minimum: Constants::LINKS_MIN_LENGHT,
    too_short: Constants::LINK_MIN_ERROR
  }


  def self.make(link="http://")
    search_for_link = Link.where(:link_source => link ).first
    return new_link = Link.create(:link_source => link ) unless search_for_link
    search_for_link
  end

end

class UserLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
  validates :user_link_name, length: {
    minimum: Constants::LINK_NAME_MIN,
    too_short: Constants::LINK_NAME_MIN_ERROR
  }
end