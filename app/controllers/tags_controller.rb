class TagsController < ApplicationController
def autocomplete_tag_name
	if params[:name]
        tags = User.select([:id,:name]).where("name LIKE ?", "%#{params[:name]}%")
      else
         tags = User.all
      end
       #   result = tags.collect do |t|
       #   { id: t.id, name: t.name }
       #  end
       #  render json: result
       render json: tags 
   end
end