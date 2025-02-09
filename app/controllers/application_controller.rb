class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!


  def after_sign_in_path_for(resource)
    if resource.super_admin?
      admin_dashboard_path  # Both admin & super admin use the same dashboard
    elsif resource.admin?
      admin_dashboard_path
    else
      root_path
    end
  end


  private

  def skip_csrf_for_api_requests
    if request.format.json? || request.path.start_with?("/api/")
      self.class.skip_forgery_protection
    end
  end
end
