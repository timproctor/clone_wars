class CloneWarsApp < Sinatra::Base

  get '/' do
    haml :index 
  end

end