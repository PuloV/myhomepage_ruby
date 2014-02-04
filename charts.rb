get "/chart" do
  redirect ("../charts/most_visited")
end

get "/charts/most_visited" do
  links = Link.all.limit(10).order(:link_visited).reverse_order
  top_visited = []
  links.map.with_index do |link , index|
    top_visited << {
      :link_name    => link.user_links.first.user_link_name ,
      :link_url     => link.link_source ,
      :link_visited => link.link_visited
    }
  end
  top_visited.each { |link| apvalue link }
  erb :most_visited , :locals => {
                               :user_id     => session["user_id"] ,
                               :top_visited => top_visited ,
                               :user_menu   => @user_menu ,
                               :top_menu    => @top_layer_menu
                             }

end