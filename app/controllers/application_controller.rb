class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  protect_from_forgery with: :null_session, if: :api_request?
  skip_before_action :verify_authenticity_token

  # Use Devise authentication for admin  only
  before_action :authenticate_user!, unless: :api_request?
  # before_action :authenticate_admin!, if: :admin_request?  # Ensure only admins use Devise auth


  helper_method :api_request?

  rescue_from Devise::MissingWarden, with: :unauthorized_access
  rescue_from ActionController::InvalidAuthenticityToken, with: :unauthorized_access

  def after_sign_in_path_for(resource)
    if resource.super_admin?
      admin_dashboard_path  # Both admin & super admin use the same dashboard
    elsif resource.admin?
      admin_dashboard_path
    elsif resource.user?
      api_v1_dashboard_path
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

  def api_request?
    request.format.json? || request.path.start_with?("/api/")
  end
  # chek admin requets
  # def admin_request?
  #   request.path.start_with?("/admin")
  # end
end
