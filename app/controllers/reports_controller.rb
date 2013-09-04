class ReportsController < ApplicationController
	before_filter :report_type, only: [:new]
	
	def new
		@report = Report.new
		@report.type = params[:type]
		respond_to do |format|
			format.js
		end
	end

	def create	
		taget_reported = Report.factory(params[:type], params[:report])
		ok = current_user.reports << taget_reported
		respond_to do |format| 
			if ok
				format.html { flash[:success] = "Reported to admin!"
					      	  redirect_to root_url }
		    	format.js	
			else
				format.html { @timeline_items = []
					    	  render 'spinner/home' }
				format.js { render :nothing => true }
			end
		end
	end

private

def report_type
	if params[:type] == "ReportUser"
		@object = User.find(params[:reported_id])
	elsif params[:type] == "ReportComment"
		@object = Comment.find(params[:reported_id])
	else
		@object = Spin.find(params[:reported_id])
	end
end
end
