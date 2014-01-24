require './require.rb'

class Links < ActiveRecord::Base
  has_many :user_has_links , through: :user_has_links
  def self.make(link="http://")
     unless Links.where(:link_source => link ).first
     new_link = Links.create(:link_source => link )
     new_link.users_has_links.create(:users_has_links_name => rand(10..20) , users_ID => 1)
     p new_link.link_ID if new_link
     end
  end

end

class Users_has_links < ActiveRecord::Base
  belongs_to :users
  belongs_to :links
end