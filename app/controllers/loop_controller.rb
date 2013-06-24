class LoopController < ApplicationController
  
  def home
    if signed_in?
     @spin = current_user.spins.build 
     @timeline_items = current_user.timeline.page(params[:page])
        #@debug = User.first
      else
        @user = User.new
      end
    end

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
 end
