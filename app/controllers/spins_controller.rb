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
			format.html {
				if ok
					flash[:success] = "Spin created!"
					redirect_to root_url
				else
					@spin = current_user.spins.build 
					@timeline_items = current_user.timeline.page(params[:page])
					render 'spinner/home'
				end
			}
			format.js {
				if ok
					render 'create'
				else

				end
			}
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
  respond_to do |format|
    if @spin.update_attributes(params[:spin])
      format.js 
    else
      redirect_to current_user
    end
  end
end

def destroy
		@spin.destroy
		redirect_to root_url
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
