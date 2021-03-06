require_relative "database"
require_relative "app/models/location"
require_relative "app/models/menu_items"
require_relative "app/models/mail"

class CloneWarsApp < Sinatra::Base

  set :root, 'lib/app'
  set :public_folder, File.dirname(__FILE__) + '/app/public'
  set :session_secret, 'calm'
  set :method_override, true

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
    display_forbidden_if_non_admin
    haml :admin_dashboard
  end

  get '/login/admin_dashboard/location' do
    display_forbidden_if_non_admin
    haml :edit_location, locals: {location: DB[:location].all.first}
  end

  get '/login/admin_dashboard/location/:id' do |id|
    display_forbidden_if_non_admin
    location = Location.new(id)

    haml :edit_location_item, locals: {location: location.hash_data}
  end

  put '/login/admin_dashboard/location/:id' do |id|
    display_forbidden_if_non_admin
    location = Location.new(id)
    location.update_location(params)

    redirect '/login/admin_dashboard/location'
  end

  get '/login/admin_dashboard/menu' do
    display_forbidden_if_non_admin
    haml :edit_menu, locals: {menu_items: DB[:menu_items].all}
  end

  get '/login/admin_dashboard/menu/add_menu_item' do
    display_forbidden_if_non_admin
    haml :add_menu_item
  end

  post '/login/admin_dashboard/menu/add_menu_item' do
    display_forbidden_if_non_admin
    MenuItems.add_item(params[:menu])

    redirect '/login/admin_dashboard/menu'
  end

  delete '/login/admin_dashboard/menu/:id' do |id|
    display_forbidden_if_non_admin
    MenuItems.delete_item(id)

    redirect '/login/admin_dashboard/menu'
  end

  get '/login/admin_dashboard/menu/:id' do |id|
    display_forbidden_if_non_admin
    menu_item = MenuItems.find(id)
    # menu_item = DB[:menu_items].where(:id => id.to_i).to_a.first


    haml :edit_menu_item, locals: {menu_item: menu_item}
  end

  put '/login/admin_dashboard/menu/:id' do |id|
    display_forbidden_if_non_admin
    MenuItems.update_item(id, params)

    redirect '/login/admin_dashboard/menu'
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

  get '/contact' do
    haml :contact
  end

  post '/contact' do
    MailDev.pony(params)
    redirect '/success'
  end

  get '/success' do
    haml :success
  end

  helpers do
    def authenticate
      if params[:username] == settings.username && params[:password] == settings.password
        session[:admin] = true
      end
    end

    def authenticated?
      session[:admin] == true
    end

    def display_forbidden_if_non_admin
      halt 401, 'Forbidden' unless authenticated?
    end
  end

end
