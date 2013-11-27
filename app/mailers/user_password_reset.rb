class UserPasswordReset < ActionMailer::Base
  default from: "no_reply@gmail.com"

	def password_reset(user)
		@user = user
		mail(to: user.email, subject: "Password Reset")
	end
end
