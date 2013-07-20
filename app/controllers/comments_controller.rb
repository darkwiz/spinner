class CommentsController < ApplicationController
	before_filter :comment_owner, only: :destroy

	def create
		@spin = Spin.find(params[:spin_id])
		@comment = @spin.comments.build(params[:comment])
		@comment.user = current_user
		@comment.save
		respond_to do |format|
			format.html { redirect_to current_user }
			#format.js
		end 
end


def destroy
		#the spin was put into @spin by the before filter spin_owner
		@comment.destroy
		redirect_to root_url
	end

end

private
	
	def comment_owner
        begin
        	@comment = current_user.comments.find(params[:id])	
        rescue
        	redirect_to(root_path) if @comment.nil?
        end
end