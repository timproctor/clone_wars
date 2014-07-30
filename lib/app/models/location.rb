require_relative '../../database'

class Location < Sequel::Model(:location)

  def initialize(id)
    @id = id
  end

  def hash_data
    DB[:location].where(:id => @id.to_i).to_a.first
  end

  def update_location(params)
    location = hash_data
    location[:address]       = params[:address]
    location[:email_address] = params[:email_address]
    location[:phone_number]  = params[:phone_number]
    location[:description]   = params[:description]

    DB[:location].where(:id => @id.to_i).update(location)
  end

end
