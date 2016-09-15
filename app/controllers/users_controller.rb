class UsersController < ApplicationController
	before_action :find_user, except: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.create(user_params)
		session[:user_id] = @user.id
		redirect_to user_path(@user)
	end

	def show
		redirect_to root_path unless logged_in?
	end

	private

	def user_params
		params.require(:user).permit(:name, :password, :tickets, :height, :happiness, :nausea, :admin)
	end

	def find_user
		@user = User.find_by(id: params[:id])
	end
end
