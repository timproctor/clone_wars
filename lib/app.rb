require_relative "./database"
require_relative "./app/models/location"
require_relative "./app/models/menu_items"

class CloneWarsApp < Sinatra::Base
  # DB 
  set :root, 'lib/app'
  set :public_folder, File.dirname(__FILE__) + '/app/public'
  set :session_secret, "calm"

  configure do
    enable :sessions
    set :username, 'jon'
    set :password, 'snow'
  end

  get '/' do
    haml :index
  end

  get '/login' do
    haml :login
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  post '/login' do
    authenticate

    if authenticated?
      redirect '/login/admin_dashboard'
    else
      redirect '/login/login_failed'
    end
  end

  get '/login/admin_dashboard' do
    halt 401, 'GTFO' unless authenticated?
    haml :admin_dashboard
  end

  get '/login/admin_dashboard/menu' do
    halt 401, 'GTFO' unless authenticated?
    haml :edit_menu
  end

  get '/login/login_failed' do
    haml :login_failed
  end

  get '/catering' do
    haml :catering
  end

  get '/location' do
    haml :location
  end

  get '/menu_dinner' do
    haml :menu_dinner
  end

  get '/restaurant' do
    haml :restaurant
  end

  get '/specialties' do
    haml :specialties
  end

  def authenticate
    if params[:username] == settings.username && params[:password] == settings.password
      session[:admin] = true
    end
  end

  def authenticated?
    session[:admin] == true
  end

end
