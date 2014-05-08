class ReportController < ApplicationController
	def generate
		@camp = Camp.find(params[:id])
	    @registrations = @camp.registrations.all.map{|s| s}
	    @paid = @registrations.select{|r| r.payment_status == "paid"}
	    @deposit = @registrations.select{|r| r.payment_status == "deposit"}
	    @price = @camp.cost
	end
end
