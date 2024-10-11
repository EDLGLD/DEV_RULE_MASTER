class HomeController < ApplicationController
  before_action :authenticate_user!  # ログインが必要
  
  def top
    if current_user.admin? || current_user.leader?
      # 管理者またはリーダーの場合、未処理の修正リクエストを表示
      @pending_rule_requests = RuleRequest.where(status: 'pending')
    elsif current_user.general?
      # 一般ユーザーの場合、自分が送った修正リクエストのステータスを表示
      @user_rule_requests = current_user.rule_requests
    end
  end
end
