Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :rules
  resources :rule_requests, only: [:index, :new, :create, :update]

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  # 500エラーハンドリング
  match "/500", to: "errors#internal_server_error", via: :all
  
  # ルート設定
  root 'home#top'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # 404エラーハンドリングを最初に配置
  match '*unmatched', to: 'errors#not_found', via: :all
end
