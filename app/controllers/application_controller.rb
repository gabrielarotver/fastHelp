class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  helper_method :current_organization
  
  def current_organization
    Organization.where(id: session[:organization_id]).first
  end
end
