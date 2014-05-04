class UsersController < ApplicationController
before_filter :login_required, :except => [:new, :create]
authorize_resource

	def new
		@user = User.new
	end

	def edit
		@user = current_user
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to(home_path, :notice => 'User was successfully created.')
		else
			flash[:error] = "This user could not be created."
  			render "new"
		end
	end

	def update
		if @user.update_attributes(user_params)
	      flash[:notice] = "#{@user.username} was revised in the system."
	      redirect_to @user
	    else
	      render :action => 'edit'
	    end
	end

	def destroy
	    @user.destroy
	    flash[:notice] = "Successfully removed #{@user.username}."
	    redirect_to users_url
  	end

	private
	def set_user
      @user = User.find(params[:id])
    end

	def user_params
		if current_user && current_user.role?(:admin)
			params.require(:user).permit(:username, :instructor_id, :role, :active, :password, :password_confirmation)
		else
			params.require(:user).permit(:username, :instructor_id, :active, :password, :password_confirmation)
		end
	end
end