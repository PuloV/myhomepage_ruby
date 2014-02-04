get '/news' do
	top_news = News.all.limit(3).order(:news_id).reverse_order
  top_news.each{|news| apvalue news}
  erb :news , :locals => {
                               :user_id => session["user_id"] ,
                               :top_news => top_news ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu
                             }
end