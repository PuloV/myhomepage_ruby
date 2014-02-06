class UserTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_wadd_new_bookmark
    post '/bookmark/add/0' , params= {:title => "MyHomePage" , :url => "http://localhost:8080"} , 'rack.session' => { :user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    get '/bookmarks' , {}, "rack.session" => {:user_id => User.where(:user_email => "test@user.local" ).first.user_id }
    assert (last_response.body.include? "MyHomePage" ) and (last_response.body.include? "http://localhost:8080" ) and (last_response.body.include? "test@user.local")
    apvalue UserLink.where(:user_link_name => "MyHomePage" ).first
    UserLink.where(:user_link_name => "MyHomePage" ).first.destroy_all
  end
end