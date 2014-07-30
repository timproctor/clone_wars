class CloneWarsApp < Sinatra::Base

  set :root, 'lib/app'
  set :public_folder, File.dirname(__FILE__) + '/app/public'

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

  post '/login' do
    if authenticate?
      redirect ('/login/admin_dashboard')
    else
      redirect ('/login/login_failed')
    end
  end

  get '/login/admin_dashboard' do
    if session[:admin] == true
      haml :admin_dashboard
    else
      halt 403, "please log in to access admin features"
    end
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

  def authenticate?
    if params[:username] == settings.username && params[:password] == settings.password
      session[:admin] = true
    end
  end

end
