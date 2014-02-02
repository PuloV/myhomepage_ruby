require './require.rb'

class Link < ActiveRecord::Base
  has_many  :users
  has_many  :users , through: :user_links
  def self.make(link="http://")
    search_for_link = Link.where(:link_source => link ).first
    return new_link = Link.create(:link_source => link ) unless search_for_link
    search_for_link
  end


end

class UserLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
end