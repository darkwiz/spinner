class TagsController < ApplicationController
def autocomplete_tag_name
	if params[:name]
        tags = User.select([:name]).where("name LIKE ?", "%#{params[:name]}%")
      else
         tags = User.all
      end
         result = tags.collect do |t|
          { value: t.name }
          end
      render json: result
   end
end