post '/bookmark/add/:id' do |id|
  user = User.where(:user_id => session["user_id"]).first
  user.make_bookmark user.user_id , params[:title] , params[:url]
  redirect to('../bookmarks')
end

post '/bookmark/edit/:id' do |id|
  user = User.where(:user_id => session["user_id"]).first
  user_link = user.user_links.where(:link_id => id ).first
  new_link = Link.make params[:url]
  con = Mysql.new('127.0.0.1', 'root', 'pass', 'myhomepage_ruby')
  rs = con.query("UPDATE `myhomepage_ruby`.`user_links` SET `user_link_name` = '#{params[:title]}' , `link_id` = '#{new_link.link_id}' WHERE `user_links`.`user_id` = #{session["user_id"]} AND `user_links`.`link_id` =#{id}")
  redirect to('../bookmarks')
end

get '/bookmark/:action/:id' do |action,id|
  if id != 0 and action !="add"
    link_source = Link.where(:link_id => id).first.link_source
    link_title  = UserLink.where(:link_id => id , :user_id => session['user_id']).first.user_link_name
  else
    link_source = ""
    link_title  = ""
  end
  erb :bookmark ,:locals => {
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu,
                               :send_rq_to => action,
                               :link_id => id ,
                               :link_source => link_source ,
                               :link_title => link_title
                             }
end



get '/bookmarks'  do
  u = User.where(:user_id => session["user_id"]).first
  links = {}
  u.user_links.map.with_index { |link , index| links[index] = {
    :user_link_name => link.user_link_name ,
    :link_source => u.links[index].link_source ,
    :link_id => link.link_id
    } }
  erb :bookmarks ,:locals => { :links => links  ,
                               :color => Constants::COLORS ,
                               :min_links_per_row => Constants::LINKS_PER_ROW ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu
                             }

end

get '/bookmarks/goto/:link' do |link|
  user_link = Link.where(:link_id => link).first
  user_link.link_visited += 1
  user_link.save
  redirect user_link.link_source
end