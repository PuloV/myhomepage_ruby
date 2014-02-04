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
  if current_user
    session["logged"] = true
    session["username"] = current_user['user_email']
    session["user_id"] = current_user['user_id']
    redirect to('../bookmarks')
  else
    session["logged"] = false
    erb :login ,:locals => {
                                   :errors => false ,
                                   :user_menu => @user_menu ,
                                   :top_menu => @top_layer_menu
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
                               :errors => false ,
                               :user_menu => @user_menu ,
                               :top_menu => @top_layer_menu
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