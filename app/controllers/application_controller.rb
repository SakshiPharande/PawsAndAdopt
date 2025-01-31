class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path  # Redirects admin to the admin dashboard
      # else
      #   user_dashboard_path  # Redirects regular users to the user dashboard
    end
  end
end
