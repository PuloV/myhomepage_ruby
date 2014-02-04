get "/news" do
	top_news = New.all.limit(3).order(:news_id).reverse_order
  erb :news , :locals => {
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu
                             }
end