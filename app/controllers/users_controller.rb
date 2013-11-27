class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show, :index]

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@books = @user.collection.books if @user.collection
		@comments = @user.collection.comments if @user.collection && @user.collection.comments
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			cookies[:auth_token] = @user.auth_token
			flash[:success] = "Welcome to Bookster!"
			UserMailer.welcome_email(@user).deliver
			redirect_to @user
		else
			render :new
		end
	end

	private

		def user_params
			params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
		end

end
