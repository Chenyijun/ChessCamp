class ReportController < ApplicationController
	def generate
		@camp = Camp.find(params[:id])
	    @registrations = @camp.registrations.all.map{|s| s}
	    @paid = @registrations.select{|r| r.payment_status == "paid"}
	    @deposit = @registrations.select{|r| r.payment_status == "deposit"}
	    @price = @camp.cost
	end

	def family_report
		@family = Family.find(params[:id])
		@students = @family.students.active.map{|s| s}
		@registrations = @family.students.active.map{|s| s.registrations}
	end

	def yearly
		 @year = params[:year]
		 @activeCamps = Camp.active.chronological
    	 @y14 = @activeCamps.select{|c| c.start_date.year==2014}
    	 @y13 = @activeCamps.select{|c| c.start_date.year==2013}
    	 @y15 = @activeCamps.select{|c| c.start_date.year==2015}
	end
end
