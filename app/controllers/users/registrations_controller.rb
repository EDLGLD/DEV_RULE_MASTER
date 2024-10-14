class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, team_name_ids: []])
  end

  def after_sign_up_path_for(resource)
    resource.update(role: :general) # デフォルトの役割を設定
    super(resource)
  end
end