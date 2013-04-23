class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update]
	before_filter :correct_user, only: [:edit, :update]
	before_filter :admin_user, only: :destroy

	def show
		@user = User.find(params[:id])
		#this is the same as using User.find(1) in the console
	end

  	def new
		@user = User.new
  	end

	def index
		@users = User.paginate(page: params[:page])
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Gigheap!"
			redirect_to @user
		else
			# If not successful/false return to new page
			render 'new'
		end
	end

	def edit
		# this may need to come out
		# @user = User.find(params[:id])
	end

	def update
		# @user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			# Handle successful update
			flash[:success] = "Profile udpated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	private
		def signed_in_user
			store_location
			redirect_to signin_url, notice: "Please sign in." unless signed_in?
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
