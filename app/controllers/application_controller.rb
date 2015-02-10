class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  around_action :user_timezone, if: :signed_in?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).append [:team_id, :first_name, :last_name]
    devise_parameter_sanitizer.for(:sign_up).append [:first_name, :last_name]
  end

  def user_timezone(&block)
    Time.use_zone(current_user.timezone, &block)
  end
end
