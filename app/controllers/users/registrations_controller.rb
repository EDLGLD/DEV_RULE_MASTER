class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  # POST /resource
  def create
    build_resource

    resource.team_name_ids = params[:user][:team_name_ids] if params[:user][:team_name_ids]

    if resource.save
      set_flash_message!(:notice, :signed_up) # フラッシュメッセージを設定
      sign_up(resource_name, resource) # サインアップ処理
      # ユーザー登録成功時にリダイレクト
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      # エラーが発生した場合、フラッシュメッセージを設定
      flash[:alert] = "#{resource.errors.count}件のエラーが発生しました: #{resource.errors.full_messages.to_sentence}"
      clean_up_passwords resource
      # ユーザー登録フォームへリダイレクト
      redirect_to new_registration_path(resource_name) # ここを変更
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, team_name_ids: []])
  end

  def after_sign_up_path_for(resource)
    resource.update(role: :general) # デフォルトの役割を設定
    super(resource)
  end
end
