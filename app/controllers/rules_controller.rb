class RulesController < ApplicationController
  before_action :set_rule, only: %i[show edit update destroy]
  before_action :set_team, only: [:index]
  before_action :authorize_user!, only: [:new, :create] # 新規作成を許可するユーザーを制限

  # GET /rules
  def index
    if @team # 特定のチームが選択されている場合
      @rules = Rule.where(team_name_id: @team.id)
    elsif current_user.team_names.any? # ユーザーが複数のチームに所属している場合
      @rules = Rule.where(team_name_id: current_user.team_names.pluck(:id))
    else
      @rules = []
      flash.now[:alert] = 'チームに所属していません。'
    end
  end

  # GET /rules/1
  def show
    # `set_rule` で取得した `@rule` に基づいてチーム情報を表示
  end

  # GET /rules/new
  def new
    @rule = Rule.new
  end

  # GET /rules/1/edit
  def edit
    # `@rule` を編集
  end

  # POST /rules
  def create
    @rule = Rule.new(rule_params)
    @rule.team_name_id = current_user.team_names.first.id # 必ずチーム名をセット

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: 'ルールが正常に作成されました。' }
        format.json { render :show, status: :created, location: @rule }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to @rule, notice: 'ルールが正常に更新されました。' }
        format.json { render :show, status: :ok, location: @rule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to rules_path, status: :see_other, notice: 'ルールが正常に削除されました。' }
      format.json { head :no_content }
    end
  end

  private

  def set_rule
    @rule = Rule.find(params[:id])
  end

  # `index` アクションでのみチーム情報をセット
  def set_team
    @team = current_user.team_names.find_by(id: params[:team_name_id])
    
    if @team.nil? && params[:team_name_id].present?
      redirect_to root_path, alert: '指定されたチームが見つかりませんでした。'
    end
  end

  # ユーザーの権限を確認するメソッド
  def authorize_user!
    unless current_user.admin? || current_user.leader?
      redirect_to rules_path, alert: 'ルールの新規作成権限がありません。'
    end
  end

  def rule_params
    params.require(:rule).permit(:title, :details, :background, :created_at, :ended_at, :team_name_id)
  end
end