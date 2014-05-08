class HomeController < ApplicationController
  require 'will_paginate/array'

  def payment_report
    @activeCamps = Camp.active.chronological
    @y14 = @activeCamps.select{|c| c.start_date.year==2014}
  end

  def payment_report13
    @activeCamps = Camp.active.chronological
    @y13 = @activeCamps.select{|c| c.start_date.year==2013}
  end 

  def payment_report15
    @activeCamps = Camp.active.chronological
    @y15 = @activeCamps.select{|c| c.start_date.year==2015}
  end

  def index
  	@activeCamps = Camp.active.chronological
    @camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    @y14 = @activeCamps.select{|c| c.start_date.year==2014}
    @y13 = @activeCamps.select{|c| c.start_date.year==2013}
    @y15 = @activeCamps.select{|c| c.start_date.year==2015}


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
  	@activeCamps = Camp.active.chronological
    @camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    @y14 = @activeCamps.select{|c| c.start_date.year==2014}
    @y13 = @activeCamps.select{|c| c.start_date.year==2013}
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
