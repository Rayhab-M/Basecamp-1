class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # Define your custom method to authenticate admins
  def authenticate_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied. Admins only!"
    end
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end

