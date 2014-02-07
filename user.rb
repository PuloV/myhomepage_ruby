post '/user/register' do
  u = User.register params[:emailreg] , params[:passwordreg]
  redirect to('../user/login') if !u.errors.any?
  erb :register ,:locals => {
                               :errors => u.errors ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu
                             }
end

post '/user/login' do
  current_user = params[:email]  ?  (User.login params[:email] , params[:password]) : (User.login params[:emailtop] , params[:passwordtop])
  unless current_user.errors.any?
    session["logged"] = true
    session["username"] = current_user['user_email']
    session["user_id"] = current_user['user_id']
    redirect to('../bookmarks')
  else
    session["logged"] = false
    erb :login ,:locals => {
                                   :errors    => current_user.errors ,
                                   :user_menu => @user_menu ,
                                   :top_menu  => @top_layer_menu ,
                                   :email     => params[:email] ,
                                   :password  => params[:password]
                                 }
  end
end

get '/user/logout' do
    session["logged"] = false
    session["username"] = nil
    session["user_id"] = nil
    redirect to('../user/login')

end

get '/login' do
    redirect to('../user/login')
end

get '/user/login'  do
  erb :login ,:locals => {
                               :errors    => false ,
                               :user_menu => @user_menu ,
                               :top_menu  => @top_layer_menu ,
                               :email     => "" ,
                               :password  => ""
                             }
end

get '/register' do
    redirect to('../user/register')
end

get '/user/register'  do
  erb :register ,:locals => {
                               :errors => false ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu
                             }
end

get '/user/lost_password/:email' do |email|
  erb :lost_password , :locals => {
                               :success => false,
                               :errors    => false ,
                               :top_menu  => @top_layer_menu ,
                               :email     => email
                             }
end

post '/user/lost_password/:email' do |email|
  user = User.where(:user_email => email).first
  password = "#{rand(100...1000000)}#{rand(36**rand(0..10)).to_s(36)}#{rand(100...9000000)}"
  mailer = Mail.deliver do
     to email
     from 'no-reply@myhomepage.local'
     subject 'New password for MyHomePage'
     body "Your new password is #{password}"
  end
  apvalue mailer
  user.user_password = User.generate_password password
  user.save
  erb :lost_password , :locals => {
                               :errors    => user.errors ,
                               :success => true,
                               :top_menu  => @top_layer_menu ,
                               :email     => email
                             }
end