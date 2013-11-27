class UserMailer < ActionMailer::Base
  default from: "no_reply@gmail.com"
  
  def welcome_email(user)
  	email = user.email
  	@name = user.first_name
  	mail(to: email, subject: "Welcome to Bookster")
  end
end
