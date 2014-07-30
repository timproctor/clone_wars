require_relative "./database"
require_relative "./app/models/location"
require_relative "./app/models/menu_items"

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
    location = DB[:location].where(:id => id.to_i).to_a.first

    haml :edit_location_item, locals: {location: location}
  end

  put '/login/admin_dashboard/location/:id' do |id|
    display_forbidden_if_non_admin
    location = DB[:location].where(:id => id).to_a.first
    location[:address]       = params[:address]
    location[:email_address] = params[:email_address]
    location[:phone_number]  = params[:phone_number]
    location[:description]   = params[:description]

    DB[:location].where(:id => id.to_i).update(location)
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
    DB[:menu_items].insert(params[:menu])

    redirect '/login/admin_dashboard/menu'
  end

  delete '/login/admin_dashboard/menu/:id' do |id|
    display_forbidden_if_non_admin
    DB[:menu_items].where(:id=>id.to_i).delete

    redirect '/login/admin_dashboard/menu'
  end

  get '/login/admin_dashboard/menu/:id' do |id|
    display_forbidden_if_non_admin
    menu_item = DB[:menu_items].where(:id => id.to_i).to_a.first

    haml :edit_menu_item, locals: {menu_item: menu_item}
  end

  put '/login/admin_dashboard/menu/:id' do |id|
    display_forbidden_if_non_admin
    menu_item               = DB[:menu_items].where(:id => id.to_i).to_a.first
    menu_item[:name]        = params[:name]
    menu_item[:ingredients] = params[:ingredients]
    menu_item[:price]       = params[:price]

    DB[:menu_items].where(:id => id.to_i).update(menu_item)
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
    require 'pony'

    Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => 'notarealemail192@gmail.com',
      :subject => params[:name] + " has contacted you",
      :body => params[:message],
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'notarealemail192',
        :password             => 'notapassword',
        :authentication       => :plain,
        :domain               => 'localhost.localdomain'
      })

    redirect '/success'
  end

  get '/success' do
    haml :success
  end
  # helpers
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
