Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :rules
  resources :rule_requests, only: [:index, :new, :create, :update]

  # Deviseのコントローラに独自アクションを追加
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  # エラーハンドリング
  match "/500", to: "errors#internal_server_error", via: :all
  match '*unmatched', to: 'errors#not_found', via: :all
  
  # ルート設定
  root 'home#top'

  # 開発環境でのメール確認
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
