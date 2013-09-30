class StylesController < ApplicationController
  before_filter :image_list, except: :show

  def show
    @style = Style.find(params[:id])
    respond_to do |format|
      format.css 
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

  def reset
    @style = Style.find(params[:id])
    if @style.update_attributes(:well_color => "#eeeeee", :background_color =>"#ffffff", :nav_inverse => true, :background_image => "")
      flash[:success] = "Profile Restored"
      redirect_to edit_style_path(@style)
    else
      flash[:error] = "Error"
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