class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, team_name_ids: []])
  end

  def create
    super do |resource|
      resource.role = :general # デフォルトの役割を設定
      resource.save if resource.valid? # ユーザーが有効な場合に保存
    end
  end
end