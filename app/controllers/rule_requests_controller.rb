class RuleRequestsController < ApplicationController
  before_action :authenticate_user! # ユーザー認証が必要
  before_action :set_rule_request, only: [:update]
  before_action :authorize_admin!, only: [:index, :update] # 管理者のみが承認・却下できる

  # 修正リクエストの一覧表示（管理者用）
  def index
    @rule_requests = RuleRequest.where(status: 'pending') || [] # nilにならないように配列で初期化
  end

  # 修正リクエストの作成
  def new
    @rule_request = RuleRequest.new
    @rules = Rule.all # すべてのルールを取得してドロップダウンなどに利用
  end

  def create
    @rule_request = RuleRequest.new(rule_request_params)
    @rule_request.user = current_user
    @rule_request.status = 'pending'

    if @rule_request.save
      User.admins.each do |admin|
        AdminMailer.rule_request_notification(admin, @rule_request).deliver_later
      end
      redirect_to rules_path, notice: "修正リクエストが送信されました。"
    else
      @rules = Rule.all # エラーが発生した場合に再度ルールを取得
      flash.now[:alert] = "修正リクエストの送信に失敗しました。"
      render :new
    end
  end

  # 修正リクエストの承認・却下
  def update
    if @rule_request.update(status: params[:status]) # params[:status]から取得
      redirect_to rule_requests_path, notice: "リクエストを#{params[:status] == 'approved' ? '承認' : '却下'}しました。"
    else
      @rule_requests = RuleRequest.where(status: 'pending') # エラー時も再度取得
      flash.now[:alert] = "リクエストの処理に失敗しました。"
      render :index
    end
  end
      
  private

  def set_rule_request
    @rule_request = RuleRequest.find(params[:id])
  end

  def rule_request_params
    params.require(:rule_request).permit(:request_details, :rule_id) # rule_idも許可
  end

  def authorize_admin!
    redirect_to root_path, alert: '管理者権限が必要です。' unless current_user.admin?
  end
end
