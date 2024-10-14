# すでに存在する場合は作成しない
team1 = TeamName.find_or_create_by(name: 'Team Alpha')
team2 = TeamName.find_or_create_by(name: 'Team Beta')

# Rulesのseedデータ
Rule.find_or_create_by!(
  title: 'First Rule for Alpha',
  team_name: team1,
  details: 'This is the first rule for Team Alpha.',
  background: 'Background information about this rule.',
  ended_at: Time.now + 1.week
)

Rule.find_or_create_by!(
  title: 'Second Rule for Alpha',
  team_name: team1,
  details: 'This is the second rule for Team Alpha.',
  background: 'Further background for this rule.',
  ended_at: Time.now + 2.weeks
)

Rule.find_or_create_by!(
  title: 'First Rule for Beta',
  team_name: team2,
  details: 'This is the first rule for Team Beta.',
  background: 'Background for the first rule of Team Beta.',
  ended_at: Time.now + 3.days
)

Rule.find_or_create_by!(
  title: 'Second Rule for Beta',
  team_name: team2,
  details: 'This is the second rule for Team Beta.',
  background: 'More background for this rule.',
  ended_at: Time.now + 10.days
)