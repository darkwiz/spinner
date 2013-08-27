class StylesController < ApplicationController
  before_filter :image_list,   only: [:edit, :update]
  caches_page :show # magic happens here (requested only when css modified)

  def show
    @style = Style.find(params[:id])
    respond_to do |format|
      format.html #regular ERB template
      format.css #{ render :text => @style.well_color, :content_type => "text/css" }
    end
  end

  def edit
    @style = Style.find(params[:id])
  end

  def update
    @style = Style.find(params[:id])
    if @style.update_attributes(params[:style])
      flash[:success] = "Profile updated"
      redirect_to edit_style_path(@style)
    else
      flash[:error] = "Error!"
      render 'edit'
    end
  end

  private

  def image_list
       @pic = []
       Dir.glob('app/assets/images/backgrounds/*').each do|f|
        @pic << f.gsub("app/assets/images/backgrounds/", "")
       end
  end
end