class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :user_activity

  private

  def user_activity
    current_user.try :touch
  end

	protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

end
