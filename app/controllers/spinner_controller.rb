class SpinnerController < ApplicationController
  
  def home
    if signed_in?
        @spin = current_user.spins.build 
        arr = current_user.timeline
        @timeline_items = Kaminari.paginate_array(arr).page(params[:page])
        #current_user.timeline.page(params[:page])
        else
        @user = User.new
      end
    end

=begin
   def search
      @users = User.all
      #@users = User.where("name like ?", "%#{params[:name]}%")
       #@users = User.search(params[:search])
     respond_to do |format|
        format .js
        format.html # index.html.erb
        format.json {  render json: @users.map(&:name) }
      end
     end
=end

end
