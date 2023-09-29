class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  rescue_from ActiveRecord::RecordNotFound, with: :handle_exception
   def handle_exception
     render json: { error: 'ID not found' }
   end
   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name,:username])
  end
end

