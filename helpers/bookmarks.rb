post '/bookmark/add/:id' do |id|
  user = User.where(:user_id => session["user_id"]).first
  user = user.make_bookmark user.user_id , params[:title] , params[:url]
  redirect to('../bookmarks') unless user.errors.messages.any?
  erb :bookmark ,:locals => {
                               :errors => user.errors ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu,
                               :send_rq_to => "add",
                               :link_id => id ,
                               :link_source => params[:url] ,
                               :link_title => params[:title]
                             }
end

post '/bookmark/edit/:id' do |id|
  user = User.where(:user_id => session["user_id"]).first
  if params[:title].size < Constants::LINK_NAME_MIN or params[:url].size < Constants::LINKS_MIN_LENGHT

    if params[:title].size < Constants::LINK_NAME_MIN
      user.errors[:title] << Constants::LINK_NAME_MIN_ERROR
    end

    if params[:url].size < Constants::LINKS_MIN_LENGHT
      user.errors[:url] << Constants::LINK_MIN_ERROR
    end
    erb :bookmark ,:locals => {
                               :errors => user.errors ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu,
                               :send_rq_to => "edit",
                               :link_id => id ,
                               :link_source => params[:url],
                               :link_title => params[:title]
                             }
  else
    user_link = user.user_links.where(:user_link_id => id ).first
    new_link = Link.make params[:url]
    con = Mysql.new(Constants::HOST, Constants::HOST_USER, Constants::HOST_PASSWORD, Constants::HOST_DATABASE)
    rs = con.query("UPDATE `myhomepage_ruby`.`user_links` SET `user_link_name` = '#{params[:title]}' , `link_id` = '#{new_link.link_id}' WHERE `user_links`.`user_link_id` = #{id} LIMIT 1")
    redirect to('../bookmarks')
  end
end

get '/bookmark/:action/:id' do |action,id|
  if id != 0 and action !="add"
    user_link = UserLink.where(:user_link_id => id , :user_id => session['user_id']).first
    link_source = Link.where(:link_id => user_link.link_id).first.link_source

    link_title  = user_link.user_link_name

  else
    link_source = ""
    link_title  = ""
  end
  erb :bookmark ,:locals => {
                               :errors => false ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu,
                               :send_rq_to => action,
                               :link_id => id ,
                               :link_source => link_source.force_encoding(Encoding::UTF_8) ,
                               :link_title => link_title.force_encoding(Encoding::UTF_8)
                             }
end



get '/bookmarks'  do
  u = User.where(:user_id => session["user_id"]).first
  links = []
  u.user_links.map.with_index { |link , index| links << {
    :user_link_name => link.user_link_name.force_encoding(Encoding::UTF_8) ,
    :user_link_id => link.user_link_id ,
    :link_source => u.links[index].link_source.force_encoding(Encoding::UTF_8) ,
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