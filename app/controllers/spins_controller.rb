class SpinsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :spin_owner, only: :destroy

	def index
	end


	def create
		@spin = current_user.spins.build(params[:spin])
		@spin.in_reply_to = get_username(params[:spin][:content])
		ok = @spin.save
		respond_to do |format| 
			format.html {
				if ok
					flash[:success] = "Spin created!"
					redirect_to root_url
				else
					@spin = current_user.spins.build 
					@timeline_items = current_user.timeline.page(params[:page])
					render 'loop/home'
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

	def destroy
		#the spin was put into @spin by the before filter spin_owner
		@spin.destroy
		redirect_to root_url
	end

	private
	# Checks if a spin is in reply to a user (if @ char is present)
	
	def get_username(txt, col = 140)
		if txt.match(/^@([A-Za-z0-9_]{1,140})/)
			txt.match(/^@([A-Za-z0-9_]{1,140})/)[0].gsub!(/^@/, '')
		end
	end

	def spin_owner
		#@spin = current_user.spins.find_by_id(params[:id])
        #redirect_to(root_path) if @spin.nil?
        begin
        	@spin = current_user.spins.find(params[:id])
        rescue
        	redirect_to(root_path) if @spin.nil?
        end
    end
end
