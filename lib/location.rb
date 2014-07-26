class Location
  attr_reader :name,
              :address,
              :phone_number,
              :email_address,
              :description

  def initialize(attributes={})
    @name          = attributes[:name]
    @address       = attributes[:address]
    @phone_number  = attributes[:phone_number]
    @email_address = attributes[:email_address]
    @description   = attributes[:description]
  end

#   DB = Sequel.sqlite

#   DB.create_table :location do
#     primary_key :id
#     String :name
#     String :address
#     String :phone_number
#     String :email_address
#     String :description
#   end
end