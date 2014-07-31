require 'pony'


class MailDev

  def self.pony(params)
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
  end

end
