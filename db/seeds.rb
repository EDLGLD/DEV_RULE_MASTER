# メモ:各項目5件以上作成する
# すでに存在する場合は作成しない
team_general = TeamName.find_or_create_by(name: 'General')
team_alpha = TeamName.find_or_create_by(name: 'Team Helpdesk')
team_beta = TeamName.find_or_create_by(name: 'Team Operation')

# Rulesのseedデータ
# Team Helpdesk用ルール
Rule.find_or_create_by!(
  title: 'タブレット保守時のRFIDリーダー利用',
  team_name: team_alpha,
  details: 'タブレット保守時にはRFIDリーダーを必ず使用すること。',
  background: 'タブレットのトラブルシューティングを効率化するため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '機材出動前の顧客連絡',
  team_name: team_alpha,
  details: '機材出動前に必ず顧客に連絡を取り、必要な情報を確認すること。',
  background: 'トラブルシューティングの成功率を高めるため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '保守作業完了報告',
  team_name: team_alpha,
  details: '保守作業が完了したら、顧客に報告を行うこと。',
  background: '顧客との信頼関係を築くため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '緊急出動時の指示',
  team_name: team_alpha,
  details: '緊急出動時は上司に連絡し、指示を仰ぐこと。',
  background: '適切な判断を行うための情報共有が重要。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '機材貸出管理',
  team_name: team_alpha,
  details: '機材を貸し出す際は、記録を残し、返却時に確認を行うこと。',
  background: '機材の紛失や破損を防ぐための記録管理。',
  ended_at: Time.now + 1.year
)

# Team Operation用ルール
Rule.find_or_create_by!(
  title: '機材登録の製造番号要件',
  team_name: team_beta,
  details: '機材情報を登録する際は、必ず製造番号を記載すること。',
  background: 'トラッキングのために正確な情報が必要。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '定期的な情報更新',
  team_name: team_beta,
  details: '機材情報は定期的に更新し、最新の状態を保つこと。',
  background: '正確なデータ管理を維持するため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '機材廃棄の承認',
  team_name: team_beta,
  details: '廃棄する機材は、事前に管理者の承認を得ること。',
  background: '無駄な廃棄を防ぎ、環境への配慮を考えるため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: 'データセキュリティ遵守',
  team_name: team_beta,
  details: 'データベースへのアクセスは、許可された者のみに制限すること。',
  background: '機密情報を守るためのセキュリティ強化。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '機材貸出記録作成',
  team_name: team_beta,
  details: '機材を貸し出す際は、必ず貸出記録を作成すること。',
  background: '追跡可能な記録を保つことで、管理を効率化。',
  ended_at: Time.now + 1.year
)

# 一般ルール (全般)
Rule.find_or_create_by!(
  title: '出社時の時間厳守',
  team_name: team_general,
  details: '社員は午前9時までに出社すること。',
  background: '遅刻を防ぎ、業務の円滑な運営を確保するため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '鍵の管理',
  team_name: team_general,
  details: '会社の鍵は各自が責任を持って管理し、紛失時は速やかに報告すること。',
  background: 'セキュリティを強化し、無断侵入を防ぐため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: 'コンプライアンス遵守',
  team_name: team_general,
  details: '業務に関連する法律や規則を遵守し、不正行為を防ぐこと。',
  background: '会社の信頼を守り、法的トラブルを避けるため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '健康管理',
  team_name: team_general,
  details: '定期的な健康診断を受け、体調管理に努めること。',
  background: '健康な職場環境を維持し、生産性を向上させるため。',
  ended_at: Time.now + 1.year
)

Rule.find_or_create_by!(
  title: '職場環境の整備',
  team_name: team_general,
  details: '自分の作業スペースは清潔に保ち、ゴミは所定の場所に捨てること。',
  background: '快適な作業環境を維持し、業務効率を向上させるため。',
  ended_at: Time.now + 1.year
)

# 管理者ユーザー (全てのチームに所属)
nakamura = User.find_or_create_by!(
  email: 'nakamura@example.com',
  username: '中村 竹郎',
  role: :admin
) do |user|
  user.password = '111111'
  user.password_confirmation = '111111'
end
nakamura.team_names = [team_general, team_alpha, team_beta]

# 一般ユーザー (Team Alpha に所属)
omura = User.find_or_create_by!(
  email: 'omura@example.com',
  username: '大村 梅郎',
  role: :general
) do |user|
  user.password = '111111'
  user.password_confirmation = '111111'
end
omura.team_names = [team_general, team_alpha]

# 一般ユーザー (Team Beta に所属)
kimura = User.find_or_create_by!(
  email: 'kimura@example.com',
  username: '木村 松郎',
  role: :general
) do |user|
  user.password = '111111'
  user.password_confirmation = '111111'
end
kimura.team_names = [team_general, team_beta]
