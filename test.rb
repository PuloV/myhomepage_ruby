require './main.rb'
require 'test/unit'
require 'rack/test'
require './require.rb'
require './test/user.rb'
require './test/bookmark.rb'
set :environment, :test
enable :sessions
#apvalue User.all
