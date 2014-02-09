get '/news' do
	top_news = News.all.limit(Constants::DISPLAY_NEWS).order(:news_id).reverse_order
  erb :news , :locals => {
                               :user_id => session["user_id"] ,
                               :top_news => top_news ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu
                             }
end