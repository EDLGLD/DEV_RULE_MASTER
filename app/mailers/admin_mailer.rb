class AdminMailer < ApplicationMailer
  def rule_request_notification(admin, rule_request)
    @admin = admin
    @rule_request = rule_request
    mail(to: @admin.email, subject: "修正リクエスト通知") # 管理者へのメール送信
  end
end