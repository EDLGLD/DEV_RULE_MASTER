class Ability
  include CanCan::Ability

  def initialize(user)
    # 管理者ユーザーにはすべての権限を与える
    if user.admin?
      can :manage, :all
      can :access, :rails_admin # RailsAdmin へのアクセスを許可
      can :dashboard, :all      # RailsAdmin のダッシュボードにアクセスを許可
    else
      # 他のユーザーは、アクセス制限を設定
      cannot :access, :rails_admin
      cannot :manage, :all
    end
  end
end
