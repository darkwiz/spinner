class SpinsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :spin_owner, only: :destroy
	def index
	end


	def create
		if params[:spin][:multimedia]
			multispin = Multispin.new(params[:spin])
			ok = current_user.spins << multispin
		else
			@spin = current_user.spins.build(params[:spin])
			ok = @spin.save
		end
		respond_to do |format| 
			if ok
				format.html { flash[:success] = "Spin created!"
					      redirect_to root_url }
		    	format.js	
			else
				format.html { @timeline_items = []
					    	  render 'spinner/home' }
				format.js { render :nothing => true }
			end
		end
	end


   def edit
		@spin = current_user.spins.find(params[:id])
		respond_to do |format|
			format.js
		end
	end


	def update
		@spin = Spin.find(params[:id])
		ok = @spin.update_attributes(params[:spin])
		respond_to do |format|
			if ok 
				format.html { flash[:success] = "Spin updated!"
				      		  redirect_to current_user }
				format.js 
			else  
				format.html { flash[:error] = "Spin update failed!"
							  redirect_to current_user }  
				format.js  
			end  
		end
	end

def destroy
		@spin.destroy
		respond_to do |format|
			format.html { redirect_to :back }
			format.js { render :nothing => true }
		end
end

	
private

	def spin_owner
        begin
        	@spin = current_user.spins.find(params[:id])
        rescue
        	redirect_to(root_path) if @spin.nil?
        end
    end
end
