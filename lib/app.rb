class CloneWarsApp < Sinatra::Base

  set :root, 'lib/app'
  set :public_folder, File.dirname(__FILE__) + '/app/public'

  DB = Sequel.sqlite # creates a sqlite database in memory

  # creates a table named items
  DB.create_table :items do
    primary_key :id
    String :name
    String :price
  end

  items = DB['items']

  get '/' do
    haml :index
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

end
