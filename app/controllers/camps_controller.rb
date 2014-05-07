class CampsController < ApplicationController

  require 'will_paginate/array'
  before_action :set_camp, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:new, :edit, :update, :destroy]
  authorize_resource 

  def index
    @upcoming_camps = Camp.upcoming.active.chronological
    @possible_to_see_upcoming_camps = @upcoming_camps.select{|c| (can? :read, c)}.paginate(:page => params[:page], :per_page => 10)

    @upcoming_camps = @possible_to_see_upcoming_camps


    @past_camps = Camp.past.chronological.paginate(:page => params[:page]).per_page(10)
    @inactive_camps = Camp.inactive.alphabetical.to_a
  end

  def show
    @instructors = @camp.instructors.alphabetical.to_a
    #@curriculums = Curriculum.all.map{|c| if c.camp_id }
    @students = @camp.students.all.map{|s| s}
  end

  def new
    @camp = Camp.new
  end

  def edit
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to @camp, notice: "The camp #{@camp.name} (on #{@camp.start_date.strftime('%m/%d/%y')}) was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @camp.update(camp_params)
      redirect_to @camp, notice: "The camp #{@camp.name} (on #{@camp.start_date.strftime('%m/%d/%y')}) was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @camp.destroy
    redirect_to camps_url, notice: "#{@camp.name} camp on #{@camp.start_date.strftime('%m/%d/%y')} was removed from the system."
  end

  private
    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(:curriculum_id, :cost, :start_date, :end_date, :time_slot, :max_students, :location_id, :active, :instructor_ids => [], :location_ids => [])
    end
end
