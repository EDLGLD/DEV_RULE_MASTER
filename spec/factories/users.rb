FactoryBot.define do
  factory :user do
    username { "test_user" } # ユーザー名を指定
    email { "test_user@example.com" } # メールアドレスを指定
    password { "password" } # パスワードを指定
    password_confirmation { "password" } # 確認用のパスワード
    role { :general } # 初期ロールを指定（必要に応じて変更）
  end
end