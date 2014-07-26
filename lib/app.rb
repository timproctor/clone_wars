class CloneWarsApp < Sinatra::Base

  set :public_folder, File.dirname(__FILE__) + '/public'

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
