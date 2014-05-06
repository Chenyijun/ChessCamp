class HomeController < ApplicationController
  def index
  	@camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    if current_user && !current_user.instructor.nil?
      @userCamps = current_user.instructor.camps.paginate(:page => params[:page]).per_page(10)
      @userInstructor = current_user.instructor
    end
  	# usercamps = current_user.instructor.camps.map{|c| c }.flatten
  	# @ucamps = usercamps.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
  end

  def show
  	@camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
  	# @usercamps = current_user.instructor.camps.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
  	#@instructors = @camp.instructors.alphabetical.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
