class LocationsController < ApplicationController
	before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource 
  skip_authorize_resource only: [:read]
  def edit
  end

  def new
  	@location = Location.new
  end

  def index
  	 @active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
     @inactive_locations = Location.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

   def create

    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, notice: "#{@location.name} location was added to the system."
    else
      render action: 'new'
    end
  end

  def show
  	#@location_camps = Camp.where(location_id: @location.id).map{ |c| c.all }
  	#@location_camps = Camp.location.chronological
  end

  def update
  	if @location.update(location_params)
      redirect_to @location, notice: "#{@location.name} location was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    if @location.destroy?
      redirect_to locations_url, notice: "#{@location.name} location was removed from the system."
    else
      redirect_to locations_url
      flash[:error] = "#{@location.name} location is used by a camp and cannot be removed"
    end
  end

  private
	def set_location
      @location = Location.find(params[:id])
    end

	def location_params
	  params.require(:location).permit(:name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :active)
	end
end
