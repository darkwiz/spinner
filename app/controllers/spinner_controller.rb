class SpinnerController < ApplicationController
  
  def home
  	if params[:set_locale]
  		redirect_to root_path(:locale => params[:set_locale])
  	else
  		if signed_in?
  			@spin = current_user.spins.build 
  			ary = current_user.timeline.sort_by(&:last_respin_time).reverse
  			@timeline_items = Kaminari.paginate_array(ary).page(params[:page])
  		else
  			@user = User.new
  		end
  	end
  end
end
