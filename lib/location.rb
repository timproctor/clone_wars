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

  def to_h
    {
      'name'          => name,
      'address'       => address,
      'phone_number'  => phone_number,
      'email_address' => email_address,
      'description'   => description
    }
  end
  
end
