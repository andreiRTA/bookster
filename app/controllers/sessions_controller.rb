class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_username(params[:session][:username])
		if user && user.authenticate(params[:session][:password])
			if params[:session][:remember_me] == "1"
				cookies.permanent[:auth_token] = user.auth_token
			else
				cookies[:auth_token] = user.auth_token
			end
			flash[:success] = "Welcome back, #{user.first_name}!"
			redirect_to user
		else
			flash.now[:danger] = "Your username and/or password is incorrect. Please try again."
			render 'new'
		end
	end

	def destroy
		cookies.delete(:auth_token)
		flash[:info] = "Successfully logged out"
		redirect_to root_path
	end
end
