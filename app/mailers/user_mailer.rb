class UserMailer < ActionMailer::Base
  default from: "Teo Dell'Amico <teo@dellamico.com>"

  def welcome_email(user)
  	@user = user
  	@url = 'http://wwww.dellamico.com'
  	mail(to: user.email, subject 'hi')
  end


end
