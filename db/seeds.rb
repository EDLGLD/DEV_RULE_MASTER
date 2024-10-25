# すでに存在する場合は作成しない
team_general = TeamName.find_or_create_by(name: 'General')
team_alpha = TeamName.find_or_create_by(name: 'Team Alpha')
team_beta = TeamName.find_or_create_by(name: 'Team Beta')

# Rulesのseedデータ
Rule.find_or_create_by!(
  title: 'First Rule for Alpha',
  team_name: team_alpha,
  details: 'This is the first rule for Team Alpha.',
  background: 'Background information about this rule.',
  ended_at: Time.now + 1.week
)

Rule.find_or_create_by!(
  title: 'Second Rule for Alpha',
  team_name: team_alpha,
  details: 'This is the second rule for Team Alpha.',
  background: 'Further background for this rule.',
  ended_at: Time.now + 2.weeks
)

Rule.find_or_create_by!(
  title: 'First Rule for Beta',
  team_name: team_beta,
  details: 'This is the first rule for Team Beta.',
  background: 'Background for the first rule of Team Beta.',
  ended_at: Time.now + 3.days
)

Rule.find_or_create_by!(
  title: 'Second Rule for Beta',
  team_name: team_beta,
  details: 'This is the second rule for Team Beta.',
  background: 'More background for this rule.',
  ended_at: Time.now + 10.days
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
omura.team_names << team_alpha

# 一般ユーザー (Team Beta に所属)
kimura = User.find_or_create_by!(
  email: 'kimura@example.com',
  username: '木村 松郎',
  role: :general
) do |user|
  user.password = '111111'
  user.password_confirmation = '111111'
end
kimura.team_names << team_beta
