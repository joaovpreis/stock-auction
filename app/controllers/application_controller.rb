class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf])
  end

  private
  def is_admin?
    unless current_user.admin?
      flash.alert = I18n.translate('devise.autorization.not_authorized')
      redirect_to root_path
    end
  end

end
