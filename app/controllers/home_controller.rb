class HomeController < ApplicationController
  def index
  	@camps = Camp.active.chronological.paginate(:page => params[:page]).per_page(10)
  	
    #@students = @camp.students.all.map{|s| s}
  end

  def show
  	@camps = Camp.active.chronological.paginate(:page => params[:page]).per_page(10)
  	#@instructors = @camp.instructors.alphabetical.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end
