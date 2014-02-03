get "/chart" do
  redirect ("../charts/most_opened")
end

get "/charts/most_opened" do
 links = Link.all.limit(10).order(:link_visited).reverse_order
 links.each {|link| apvalue link }
end