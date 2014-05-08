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
		 @activeCamps = Camp.active.chronological
    	 @y14 = @activeCamps.select{|c| c.start_date.year==2014}
	end
end
