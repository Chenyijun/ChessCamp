class HomeController < ApplicationController
  require 'will_paginate/array'
  def index
  	@activeCamps = Camp.active.chronological
    @camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)

    if current_user && !current_user.instructor.nil?
      @userCamps = current_user.instructor.camps
      @possible_to_see_upcoming_camps = @userCamps.select{|c| (can? :read, c)}.paginate(:page => params[:page], :per_page => 10)
      @userCamps = @possible_to_see_upcoming_camps

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
