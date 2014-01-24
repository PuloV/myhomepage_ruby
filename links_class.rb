require './require.rb'

class Links < ActiveRecord::Base
  has_many :users_has_links

  def self.make(link="http://")
    unless Links.where(:link_source => link ).first
      new_link = Links.create(:link_source => link )
      Users_has_links.create({:users_has_links_name => rand(10..20).to_s , :user_ID => 1 , :link_ID => new_link.link_ID})
      #self.users_has_links.create({:users_has_links_name => rand(10..20).to_s , :user_ID => 1 , :link_ID => new_link.link_ID})
    end
  end

  def self.testing
    p self.user_has_links.all
    return self.users_has_links.all
  end

end

class Users_has_links < ActiveRecord::Base
  belongs_to :users
  belongs_to :links
end