class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  protect_from_forgery
  # Makes session helpers available in all controllers
  # by default, all the helpers are available from the views but not from the controllers.
  
  include SessionsHelper  



  # For example, if you pass a Proc object, the block you give the Proc will be given the controller instance,
  # so the layout can be determined based on the current request: (in this case no layout if xhr or default application layout)
 
  layout Proc.new { |controller| controller.request.xhr? ? nil : 'application' }

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out_user
    super
  end
 
 protected

 def set_i18n_locale_from_params 
  if params[:locale]
    if I18n.available_locales.include?(params[:locale].to_sym) 
      I18n.locale = params[:locale]
    else
      flash.now[:notice] = "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
    end 
  end
end

  def default_url_options
   { :locale => I18n.locale }
  end
end
