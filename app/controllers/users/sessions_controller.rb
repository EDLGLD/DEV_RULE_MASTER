class Users::SessionsController < Devise::SessionsController
  def create
    # ユーザー名でユーザーを検索
    self.resource = User.find_by(username: params[resource_name][:username])

    # ユーザーが存在し、パスワードが正しいかを確認
    if resource&.valid_password?(params[resource_name][:password])
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)

      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      # ログイン失敗時の処理
      flash.now[:alert] = 'Invalid username or password.'
      respond_with resource, location: new_session_path(resource_name)
    end
  end

  # auth_optionsは不要なため削除
end