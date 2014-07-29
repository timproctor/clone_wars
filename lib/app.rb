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

  get '/login/login_failed' do
    haml :login_failed
  end

  post '/login' do
    #find username and password from params
    #authenticate
    #if user is admin, route to admin_console view, error if not
    # haml :login_failed
    redirect '/login/login_failed'
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

  def authenticate!
    if params[:username] == settings.username && params[:password] == settings.password
      sessions[:admin] = true
    end
  end

end
