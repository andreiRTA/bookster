module SessionsHelper

	def signed_in?
		!!cookies[:auth_token]
	end

	def current_user
		user = User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
	end
end
