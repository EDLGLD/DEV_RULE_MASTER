class Users::SessionsController < Devise::SessionsController
  def create
    # ユーザー名でユーザーを検索
    self.resource = User.find_by(username: params[resource_name][:username])

    # ユーザーが存在し、パスワードが正しいかを確認
    if resource&.valid_password?(params[resource_name][:password])
      set_flash_message!(:notice, :signed_in)  # 成功メッセージを設定
      sign_in(resource_name, resource)

      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      # ログイン失敗時の処理
      set_flash_message!(:alert, :invalid)  # Deviseの無効メッセージを設定
      self.resource = User.new  # resourceがnilの場合、エラーメッセージを表示するために新しいリソースを生成
      respond_with resource, location: new_session_path(resource_name)
    end
  end
end
