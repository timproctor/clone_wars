class User

  attr_reader :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  # pass 2 args to use settings.uername/password vars
  def admin?(correct_username, correct_password)
    username == correct_username && password == correct_password
  end

  # pass in session[:admin] in controller
  def authenticate_admin(session_admin)
    session_admin = true if admin?
  end
end
