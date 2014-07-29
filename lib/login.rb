class Login

  attr_reader :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  def authenticated?
    username == "jon" && password == "snow"
  end

end
